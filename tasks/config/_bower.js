module.exports = function(grunt){
  grunt.config.set('bower', {

      options: {
        targetDir: './assets/vendor',
        layout: "byComponent",
        verbose: false,
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
  });

  grunt.loadNpmTasks('grunt-bower-task');

};