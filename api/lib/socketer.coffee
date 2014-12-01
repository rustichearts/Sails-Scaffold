log = ->
  console.log.apply console, arguments  if typeof console isnt "undefined"

class Socketer
  self = null
  io = null
  constructor: (io)->
    self = this
    @io = io

  socketBind: (room, onConnect, onDisconnect) ->
    room = ""  unless typeof (room) is "string"
    unless onConnect?
      onConnect = (appSocket, roomSocket, socket) ->
        log "implements function on Connect"
        return

    roomSocket = self.io.of(room).on "connection", (socket) ->

      setTimeout ->
        onConnect self.io.sockets, roomSocket, socket
        return
      , 100

      if onDisconnect?
        socket.on "disconnect", ->
          setTimeout ->
            onDisconnect self.io.sockets, roomSocket, socket
            return
          , 100

    return roomSocket

module.exports = Socketer