module.exports = function(gulp, plugins, growl) {
  gulp.task('dev', function(cb) {
    plugins.sequence(
      ['daemon:node'],
      ['browser-sync','proxy'],
      cb
    );
  });
};