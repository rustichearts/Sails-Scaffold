module.exports = function(gulp, plugins, growl) {
  gulp.task("stylus:dev", function() {
   return gulp.src("assets/**/*.styl")
      .pipe(plugins.stylus())
      .pipe(gulp.dest(".tmp/public"))
      .pipe(plugins["if"](growl, plugins.notify({
        message: 'stylus dev task complete'
      })));
  });
};
