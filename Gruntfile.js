/**
 * Gruntfile
 *
 * This Node script is executed when you run `grunt` or `sails lift`.
 * It uses a "gulp", This file is a dummy.
 */

module.exports = function (grunt) {

	grunt.loadNpmTasks('grunt-notify');	
	grunt.loadNpmTasks('grunt-bower-task');	

    grunt.initConfig({
		notify_hooks: {},
		bower:{
			options: {
			    targetDir: './assets/vendor',
			    layout: "byComponent",
			    verbose: true,
			    install: true,
			    cleanTargetDir: true,
			    bowerOptions: {}
			  },
			  i: {
			    cleanBowerDir: false
			  },
			  dev: {
			    options: {
			      install: false,
			      cleanBowerDir: false
			    }
			  },
			  prod: {
			    options: {
			      cleanBowerDir: true
			    }
			  }
			}
		
	});

	grunt.registerTask('default',["notify_hooks"]);
};