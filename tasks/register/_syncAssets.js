module.exports = function (grunt) {
	grunt.registerTask('syncAssets', [
		'jst:dev',
		'less:dev',
    "stylus:dev", //Custom
		'sync:dev',
		'coffee:dev'
	]);
};