###
Compiles Stylus files.

---------------------------------------------------------------

For usage docs see:
https://github.com/gruntjs/grunt-contrib-stulus
###
module.exports = (grunt) ->
  grunt.config.set "stylus",
    dev:
      options:
        compress: false
      files: [
        {
          expand: true,
          cwd: 'assets/styles/',
          src: ['*.styl'],
          dest: '.tmp/public/styles/',
          ext: '.css'
        }
      ]

  return