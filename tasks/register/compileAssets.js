module.exports = function (gulp, plugins) {
	gulp.task('compileAssets', function(cb) {
		plugins.sequence(
			'clean:dev',
      'jst:dev',
      'coffee:dev',
			['less:dev','stylus:dev','copy:dev'],
			cb
		);
	});
};
