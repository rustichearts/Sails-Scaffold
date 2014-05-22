do(w=window,d=document,$=jQuery)->

  pageloader = w.pageloader = w.pageloader || {}
  if pageloader.index
    return

  # log output
  log = ->
    if (typeof console isnt 'undefined')
      console.log.apply(console, arguments);

  io=window.io
  port=window.sailsPort

  # for reverse proxy
  details = if port then { port: port } else undefined

  # Socket.io events binding Class
  socketer = new Socketer( io, details )
  indexSocket = socketer.bind "/index", ( appSocket, socket ) ->
    log "index room connect"

    socket.on "connected", (data)->
      log data
  log indexSocket

  class Loader

    constructor: ->
      return

    ready: ->
      setTimeout ->
        indexSocket.emit "load", "loaded"
      , 2000
      return


  pageloader.index = ->
    loader = new Loader()
    $ loader.ready
    return loader