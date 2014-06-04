do(w=window,d=document,$=jQuery)->

  w.pageloader = w.pageloader || {}
  if w.pageloader.index
    return

  # log output
  log = ->
    if (typeof console isnt 'undefined')
      console.log.apply(console, arguments);

  class Loader
    io=window.io
    self = null
    socketer = null
    pageSocket = null

    constructor: ->
      self = this
      # for reverse proxy
      port=window.sailsPort
      details = if port then { port: port } else undefined

      # Socket.io events binding Class
      socketer = new Socketer( io, details )
      pageSocket = socketer.bind "/index", ( appSocket, socket ) ->
        log "index room connect"

        socket.on "connected", (data)->
          log data
      , ->
        log "disconnect"

      log pageSocket

    ready: ->
      setTimeout ->
        pageSocket.emit "load", "page loaded"
      , 1000

    destroy: ->
      socketer.unbind("/index")
      return

  w.pageloader.index = ->
    loader = new Loader()
    $ loader.ready
    return loader