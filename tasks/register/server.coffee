module.exports = (grunt)->
  grunt.registerTask "server", (target)->
    grunt.task.run(["external_daemon:forever", "configureProxies", "connect:front", "watch:dummy"])
