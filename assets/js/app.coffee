do ( d=document, w=window, io=io, port=sailsPort ) ->

  # log output
  log = ->
    if (typeof console isnt 'undefined')
      console.log.apply(console, arguments);

  # for reverse proxy
  details = if port then { port: port } else undefined

  # Socket.io events binding Class
  socketer = new Socketer( io, details )
  socketer.bind ( appSocket, socket ) ->

    # Listen for Comet messages from Sails
    socket.on 'message', ( data ) ->

      # ///////////////////////////////////////////////////////////
      # // Replace the following with your own custom logic
      # // to run when a new message arrives from the Sails.js
      # // server.
      # ///////////////////////////////////////////////////////////
      if( data.status == "OK" )
        log( 'New comet message received :: ', data )

    # //////////////////////////////////////////////////////

    socket.on "count", ( data ) ->
      if( data.status == "OK" )
        log( "Application connecting is ", data.results.count)

    #  ///////////////////////////////////////////////////////////
    #  // Here's where you'll want to add any custom logic for
    #  // when the browser establishes its socket connection to
    #  // the Sails.js server.
    #  ///////////////////////////////////////////////////////////
    log(
      'Socket is now connected and globally accessible as `socket`.\n' +
      'e.g. to send a GET request to Sails, try \n' +
      '`socket.get("/", function (response) ' +
      '{ console.log(response); })`'
    )

    # ///////////////////////////////////////////////////////////

  socketer.bind "/counter", (appSocket, socket)->

    socket.on "connected", (data)->
      console.log "/counter connected"
      log data

