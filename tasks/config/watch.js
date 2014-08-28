/**
 * Run predefined tasks whenever watched file patterns are added, changed or deleted.
 *
 * ---------------------------------------------------------------
 *
 * Watch for changes on
 * - files in the `assets` folder
 * - the `tasks/pipeline.js` file
 * and re-run the appropriate tasks.
 *
 *
 */
module.exports = function(gulp, plugins, growl) {
	gulp.task('watch:api', function() {
		// Watch Style files
		return gulp.watch('api/**/*', ['watch:receive']);
	});
	
	gulp.task('watch:assets', function() {
		// Watch assets
		return gulp.watch(['assets/**/**/*', 'tasks/pipeline.js'], ['watch:receive']);
	});

  gulp.task('watch:receive', function(cb){
    plugins.sequence(
      'syncAssets',
      "bs-reload",
      cb
    );
  })

};
