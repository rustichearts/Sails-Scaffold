do ( d=document, w=window, io=io, port=sailsPort ) ->

  # log output
  log = ->
    if (typeof console isnt 'undefined')
      console.log.apply(console, arguments);

  app = angular.module("myApps", ["ngAnimate"])

  ###
  Socket.io Manager
  ###
  app.provider "socketer", ->

    details = if port then {port:port} else undefined

    @setDetails = (config) ->
      details = angular.extend(details or {}, config)

    @$get = ->
      return new Socketer(io, details)

    return @