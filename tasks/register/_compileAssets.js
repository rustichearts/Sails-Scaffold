module.exports = function (grunt) {
	grunt.registerTask('compileAssets', [
		'clean:dev',
		'jst:dev',
		'less:dev',
    "stylus:dev", // Custom
		'copy:dev',
		'coffee:dev'
	]);
};
