###
Bootstrap
(sails.config.bootstrap)

An asynchronous bootstrap function that runs before your Sails app gets lifted.
This gives you an opportunity to set up your data model, run jobs, or perform some special logic.

For more information on bootstrapping your app, check out:
http://links.sailsjs.org/docs/config/bootstrap
###

log = ->
  console.log.apply console, arguments  if typeof console isnt "undefined"

socketBind = (room, onConnect, onDisconnect) ->

  io = sails.io
  room = ""  unless typeof (room) is "string"
  unless onConnect?
    onConnect = (appSocket, roomSocket, socket) ->
      log "implements function on Connect"
      return

  return roomSocket = io.of(room).on "connection", (socket) ->
    setTimeout (->
      onConnect io.sockets, roomSocket, socket
      return
    ), 100

    if onDisconnect?
      socket.on "disconnect", ->
        setTimeout (->
          onDisconnect io.sockets, roomSocket, socket
          return
        ), 100

module.exports.bootstrap = (cb) ->

  # total count
  counterRoom = "/counter"
  socketBind counterRoom, onConnect = (appSocket, roomSocket, socket) ->
    count = Object.keys(roomSocket.sockets).length
    console.log "application connect count:open is " + count

    #      console.log( roomSocket.sockets );
    appSocket.emit "count",
      status: "OK"
      results:
        count: count

    socket.emit "messege", "loaded"

  , onDisconnect = (appSocket, roomSocket, socket) ->
    count = Object.keys(roomSocket.sockets).length
    console.log "application connect count:close is " + count
    appSocket.emit "count",
      status: "OK"
      results:
        count: count

  # page spot
  socketBind "/index", onConnect = (appSocket, roomSocket, socket) ->
    socket.emit "connected", "connected"
    socket.on "load", (data)->
      log data

  , onDisconnect = (appSocket, roomSocket, socket) ->
      return


  # It's very important to trigger this callback method when you are finished
  # with the bootstrap!  (otherwise your server will never lift, since it's waiting on the bootstrap)
  cb()