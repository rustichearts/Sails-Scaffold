###
Compile CoffeeScript files to JavaScript.

---------------------------------------------------------------

Compiles coffeeScript files from `assest/js` into Javascript and places them into
`.tmp/public/js` directory.

For usage docs see:
https://github.com/gruntjs/grunt-contrib-coffee
###
module.exports = (grunt) ->
  grunt.config.set "coffee",
    dev:
      options:
        bare: true
        sourceMap: true
        sourceRoot: "./"

      files: [
        {
          expand: true
          cwd: "assets/js/"
          src: ["**/*.coffee"]
          dest: ".tmp/public/js/"
          ext: ".js"
        }
        {
          expand: true
          cwd: "assets/_linker/js/"
          src: ["**/*.coffee"]
          dest: ".tmp/public/_linker/js/"
          ext: ".js"
        }
      ]

  return