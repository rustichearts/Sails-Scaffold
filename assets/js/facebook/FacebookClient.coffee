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
    subscribe = {}
    loadedCallback = ->
      log "FaceBook SDK loaded..."


    FB: null
    constructor: () ->
      self = @

      w.fbAsyncInit = ->
        self.FB = FB

        # Facebook JavaScript SDKの初期化
        FB.init
          appId: appId
          status: true
          xfbml: true
          cookie: true

        loadedCallback()
        if subscribe["loaded"]
          for c in subscribe["loaded"]
            c(FB)

    subscribe: (event, cb) ->

      if ( ! _is("String", event ) or ! _is("Function", cb ) )
        return

      if subscribe[event] == undefined
        subscribe[event] = new Array()
      subscribe[event].push(cb)

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

    callbacks: (cb=(->)) ->
      if !(_is "Function",cb)
        cb = (->)

      setTimeout ->
        @FB.ui
          method: "oauth"
          client_id: window.appId
          api_key: window.appId
          app_id: window.appId
          fbconnect: "1"
          response_type: "code token"
          perms: "user_friends,user_events,friends_events"
          scope: "user_friends,user_events,friends_events"
          display: "iframe"
          , cb
      , 10

    getLoginStatus: (cb={}) ->

      if !(_is "Function", cb.connected)
        cb.connected = (r)->
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
          log response
          cb.not_login(response)


    instance = null
    w.FacebookClient = ->
      instance ?= new FacebookClient()