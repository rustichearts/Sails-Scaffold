###
Compile CoffeeScript files to JavaScript.

---------------------------------------------------------------

Compiles coffeeScript files from `assest/js` into Javascript and places them into
`.tmp/public/js` directory.

For usage docs see:
https://github.com/gruntjs/grunt-contrib-coffee
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
          src: ['**/*.styl'],
          dest: '.tmp/public/styles/',
          ext: '.css'
        }
        {
          expand: true
          cwd: "assets/_linker/styles/"
          src: ["**/*.styl"]
          dest: ".tmp/public/_linker/styles/"
          ext: ".css"
        }
      ]

  grunt.loadNpmTasks "grunt-contrib-stylus"
  return