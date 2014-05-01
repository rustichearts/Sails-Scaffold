###
For usage docs see:
https://github.com/tomusdrw/grunt-contriv-connect
https://github.com/tomusdrw/grunt-connect-proxy

###
module.exports = (grunt) ->

  mountFolder = (connect, dir) ->
    connect.static require("path").resolve(dir)

  proxySnippet = require("grunt-connect-proxy/lib/utils").proxyRequest

  ########
  # config
  ########
  LIVERELOAD_PORT = 35729
  listen = 3000
  port = process.env.PORT or 1337
  try
    config = require("../../config/local")
    port = config.port or port
  catch e
    console.log e

  grunt.config.set "connect",
    front:
      options:
        host: "localhost"
        port: listen
        protocol: 'http'
        middleware: (connect) ->
          [
            mountFolder(connect, ".")
            proxySnippet
          ]
        livereload: LIVERELOAD_PORT
#          open:
#            target: "http://localhost:" + listen,
#            appName: "Google Chrome Canary"
#            callback: ->
#              return

    proxies: [
      context: "/"
      host: "localhost"
      port: port + ""
      https: false
      changeOrigin: false
    ]

  return