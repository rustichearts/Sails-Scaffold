###
Run predefined tasks whenever watched file patterns are added, changed or deleted.

---------------------------------------------------------------

Watch for changes on files in the `assets` folder,
and re-run the appropriate tasks.

For usage docs see:
https://github.com/gruntjs/grunt-contrib-watch
###
module.exports = (grunt) ->
  grunt.config.set "watch",
    api:
    # API files to watch:
      files: ["api/**/*"]

    coffee:
      files: [
        "assets/js/**/*.coffee"
      ]
      tasks: [
        "coffee:dev"
        "sails-linker:devJs"
      ]

    template:
      files: [
        "assets/templates/**/*.html"
      ]
      tasks: [
        "jst:dev"
        "sails-linker:devTpl"
      ]

    less:
      files: [
        "assets/styles/**/*.less"
      ]
      tasks: [
        "less:dev"
        "sails-linker:devStyles"
      ]

    stylus:
      files: [
        "assets/styles/**/*.styl"
      ]
      tasks: [
        "stylus:dev"
        "sails-linker:devStyles"
      ]

    view:
    # View files to watch:
      files: [
        "views/**/*"
      ]
      options:
        livereload: true

    static1:
      files: [
        "assets/**/*.!(coffee|map|less|styl|sass|scss)"
      ]
      tasks: [
        "sync:dev"
      ]

    static2:
      files: [
        ".tmp/public/**/*.!(coffee|map|less|styl|sass|scss)"
      ]
      options:
        livereload: true

#    assets:
#    # Assets to watch:
#      files: [
#        "assets/**/*"
#      ]
#
#    # When assets are changed:
#      tasks: [
#        "compileAssets"
#        "linkAssets"
#      ]
#

    dummy:
      files: [
        "dummy"
      ]

  return