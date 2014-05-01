###
For usage docs see:
https://github.com/gruntjs/grunt-bower-task
###
module.exports = (grunt) ->
  grunt.config.set "bwr", grunt.file.readJSON(".bowerrc")

  # Bower Task
  grunt.config.set "bower",
    options:
      targetDir: './assets/vendor'
      layout: "byComponent"
      verbose: false
      install: true
      cleanTargetDir: true
      bowerOptions: {}
    i:
      cleanBowerDir: false
    dev:
      options:
        install: false
        cleanBowerDir: false
    prod:
      options:
        cleanBowerDir: true

  return