# #if use jQuery this select
# do ( d = document, w = window, io = io, $ = jQuery ) ->
do ( d = document, w = window, io = io ) ->

  #** Simple log function to keep the example simple **#
  log = ->
    console.log.apply console, arguments  if typeof console isnt "undefined"

  # Socket.io events binding Class
  socketer = w.Socketer(io)

  log "mail.coffee"

#  $ ->
#    log( "load main.coffee" )