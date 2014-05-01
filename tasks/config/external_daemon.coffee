###
For usage docs see:
https://github.com/gruntjs/grunt-contrib-watch
###
module.exports = (grunt) ->

  grunt.config.set "external_daemon",
    redis:
      cmd: "redis-server"
#          args: ["<%= grunt.config.redis_config_file %>"]
      options:
        verbose: true
    "node-inspector":
      cmd: "node-inspector"
    forever:
      cmd: "forever"
      args: ["-w","app.js"]
      options:
        verbose: true

  return