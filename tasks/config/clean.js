/**
 * Clean files and folders.
 *
 * ---------------------------------------------------------------
 *
 * This gulp task is configured to clean out the contents in the .tmp/public of your
 * sails project.
 *
 */
module.exports = function(gulp, plugins, growl) {

  var del = require('del');

  gulp.task('clean:dev', function(cb) {
    del(['.tmp/public/**/*.*', '.tmp/public{,/**}'], cb);
  });

  gulp.task('clean:build', function(cb) {
    del(['www/**/*.*', 'www{,/**}'], cb);
  });

};
