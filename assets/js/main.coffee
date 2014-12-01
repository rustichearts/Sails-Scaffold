## view extends
do (w=window,d=document) ->

  #** Simple log function to keep the example simple **#
  log = ->
    console.log.apply console, arguments  if typeof console isnt "undefined"

  ## jQuery Object
  $ = angular.element

  ## when document load
  $ ->
    return

  ## angular application
  app = angular.module("myApps")

  ## application section
  app.controller "appCtrl", [ "$scope", "$document", "socketer", ($scope, $document, socketer)->

    $scope.$data = $scope.$data || {}
    $scope.$fn = $scope.$fn || {}

    log("Socket.io Connecting...")
    socketer.bind "/", ->
      log("Socket.io Connected!!!")

  ]