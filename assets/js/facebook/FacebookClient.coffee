# Socket.coffee
do(w=window,d=document,appId=window.appId) ->

  # ref http://qiita.com/Layzie/items/465e715dae14e2f601de
  _is = (type, obj) ->
    clas = Object.prototype.toString.call(obj).slice(8, -1)
    return obj isnt undefined && obj isnt null && clas is type

  # log output
  log = ->
    if (typeof console isnt 'undefined')
      console.log.apply(console, arguments);

  ## WebSocket room implements
  class FacebookClient
    FB: null
    loadedCallback: ->
      log "FaceBook SDK loaded..."
      return
    constructor: () ->
      self = @

      w.fbAsyncInit = ->
        self.FB = FB

        # Facebook JavaScript SDKの初期化
        FB.init
          appId: appId
          status: true
          xfbml: true

        if _is("Function", self.loadedCallback )
          self.loadedCallback()

    load: (cb)->

      if _is("Function", cb )
        @loadedCallback = cb

      s = "script"
      id = "facebook-jssdk"

      if d.getElementById(id)
        return

      log "FaceBook SDK loading"

      fjs = d.getElementsByTagName(s)[0]
      js = d.createElement(s)
      js.id = id
      js.async = false
      js.src = "//connect.facebook.net/en_US/all.js"
      fjs.parentNode.insertBefore(js, fjs)

    isLoadedSDK: ->
      return @.FB is not null

    getLoginStatus: (cb={}) ->

      if !(_is "Function", cb.connect)
        cb.connect = (r)->
          log "coonnected"
      if !(_is "Function", cb.not_authorized)
        cb.not_authorized = (r)->
          log "not_authorized"
      if !(_is "Function", cb.not_login)
        cb.not_login = (r)->
          log "not_login"

      if( @.FB is null )
        return log "not loading FaceBookSDK..."

      @FB.getLoginStatus (response) ->
        if (response.status == "connected")
          cb.connected(response)
        else if (response.status == "not_authorized")
          cb.not_authorized(response)
        else
          cb.not_login(response)

  do ->
    instance = null
    w.FacebookClient = ->
      if ( instance )
        instance
      else
        instance = new FacebookClient()