module.exports = function (grunt) {
	grunt.registerTask('compileAssets', [
		'clean:dev',
		'jst:dev',
		'less:dev',
    'stylus:dev',
		'copy:dev',
		'coffee:dev'
	]);
};
