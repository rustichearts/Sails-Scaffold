do(d=document,w=window,$=jQuery)->

  ## canonical 追加
  $linkCanonical =  $( "link[rel^='canonical']" )
  if(! $linkCanonical[0] )
    $linkCanonical = $('<link rel="canonical">')
    $linkCanonical.appendTo("head")

  #** Simple log function to keep the example simple **#
  log = ->
    console.log.apply console, arguments  if typeof console isnt "undefined"

  class Router extends Kazitori
    beforeAnytime:["beforeAny"]
    routes:
      "/root": "root"

    beforeAny: ->
      log "kazitori.js routing before any call"
      ## canonical 書き換え
      if( $linkCanonical[0] )
        $linkCanonical.attr( 'href', location.href )

      ## csrf 書き換え
      $.get d.location.origin + "/csrfToken", (response)->
        if(response?._csrf )
          $('meta[name=csrf-token]').attr( 'content', response._csrf )

    root: ->
      log "using kazitori function-root"
      w.pageloader["root"]()

  # Router
  w.Router = Router