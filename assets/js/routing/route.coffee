do ( d=document, w=window, $=jQuery ) ->

  ## canonical 追加
#  $('<link rel="canonical">').appendTo("head")

  #** Simple log function to keep the example simple **#
  log = ->
    console.log.apply console, arguments  if typeof console isnt "undefined"

  class Router extends Kazitori
    beforeAnytime:["beforeAny"]
    routes:
      "/": "index"

    beforeAny: ->
      log "kazitori.js routing before any call"
      ## canonical 書き換え
      # $('link[rel=canonical]').attr( 'href', location.href )

      ## csrf 書き換え
      $.get d.location.origin + "/csrfToken", (response)->
        if(response?._csrf )
          $('meta[name=csrf-token]').attr( 'content', response._csrf )

    index: ->
      log "using kazitori function-index"
      w.pageloader["index"]()

  # Router
  w.Router = Router