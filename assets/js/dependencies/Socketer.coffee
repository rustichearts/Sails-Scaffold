# Socket.coffee
do(w=window,d=document) ->

  # ref http://qiita.com/Layzie/items/465e715dae14e2f601de
  _is = (type, obj) ->
    clas = Object.prototype.toString.call(obj).slice(8, -1)
    return obj isnt undefined && obj isnt null && clas is type

  # log output
  log = ->
    if (typeof console isnt 'undefined')
      console.log.apply(console, arguments);

  authority = ->
    href = location.href.match(/^(https?):\/{2,3}(([0-9a-zA-Z\.\-:]+?):?([0-9]*?))\//i)
    return {
      input: href[0]
      url: href[2]
      protcol: href[1]
      fqdn: href[3]
      port: href[4]
    }

  domain = ->
    ref = authority()
    base = ref.protcol + "://" + ref.fqdn + ":" + ref.port
    if( base != ref.url and ref.port == "" )
      port = if ref.protcol == "https" then "433" else "80"
      base = base + port

    return base

  ## WebSocket room implements
  class Socketer

    constructor: ( @io, details ) ->

      @self = this
      @details = details
      @domain = domain()
      @volatile= new Array()
      return

    getSocket: ( room ) ->

      if ( ! _is( "String", room ) )
        room = ""

      sockets = @io.sockets[@domain]
      return if sockets then sockets.namespaces[room] else undefined

#    # For PJAX to volatilize unnecessary Socket in a single page
#    once: ( room, connect, rebind = true ) ->
#
#      if ( _is( "Function", room ) )
#        connect = room
#        room = ""
#
#      if ( ! _is( "Function", connect ) )
#        connect = ->
#          return
#
#      volatile = @volatile
#
#      return @self.bind(room, ( socket )->
#        volatile.push( socket )
#        connect( socket )
#      , rebind )
#
#    flash: ->
#
#      if @volatile.length > 0
#
#        for i in [@volatile.length-1..0]
#          socket = @volatile[i]
#          obj = @self.getSocket(socket.name)
#          obj.socket.disconnect()
#          socket.disconnect()
#
#          @volatile.splice(i,1)
#
#      return @self

    bind: ( room="", connect=(->), disconnect=(->) ) ->

      if ( _is( "Function", room ) )
        disconnect = connect
        connect = room
        room = ""

      if ( ! _is( "String", room ) )
        room = ""

      socket = @self.getSocket(room)

      if( socket )
        log( "Already Connecting...", socket )
        if( socket.socket.isClosed )
          socket.socket.open()
        socket.socket.connect(connect)
        return socket

      if room == ""
        socket = @io.connect( undefined, @self.details )
      else
        socket = @io.connect( room, @self.details )

      socket.on "connect", ->

        if( _is("Function",connect) )
          # callback
          setTimeout( ->
            connect( io.sockets, socket )
          ,1)

      socket.on "disconnect", ->
        if( _is("Function", disconnect) )
          setTimeout( ->
            disconnect( io.sockets, socket )
          ,1)

      return socket

    unbind: (room="") ->

      socket = @self.getSocket(room)
      if( socket )
        socket.disconnect()
      return socket

  ## end class Socketer

  instance = null
  w.Socketer = ( io, details )->
    instance ?= new Socketer( io, details )
