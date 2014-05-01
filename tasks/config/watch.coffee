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

    assets:
    # Assets to watch:
      files: [
        "assets/**/*"
      ]

    # When assets are changed:
      tasks: [
        "compileAssets"
        "linkAssets"
      ]

    static:
    # View files to watch:
      files: [
        ".tmp/public/**/*"
        "views/**/*"
      ]
      options:
        livereload: true

    dummy:
      files: [
        "dummy"
      ]

  return