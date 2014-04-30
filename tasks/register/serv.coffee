module.exports = (grunt)->
  grunt.registerTask "serv", (target)->
    grunt.task.run(["external_daemon:forever", "external_daemon:redis", "configureProxies", "connect:front", "watch:dummy"])