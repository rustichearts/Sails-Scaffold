module.exports = function(gulp, plugins, glowl) {
  var browserSync = require('browser-sync');
  var isReloading =false;

  gulp.task('proxy', function() {
    browserSync({
      proxy: "localhost:1337",
      port: 3000
    });
  });

  gulp.task("bs-reload", function() {
    if(!isReloading){
      isReloading = true;
//      console.log("Reloading now...");
      browserSync.reload()
      setTimeout(function(){
//        console.log("Reloading end...");
        isReloading = false;
      }, 1000);
    }
  });

  gulp.task("browser-sync", function() {
    return gulp.watch(["views/**/*"], ['bs-reload'], function(files) {
      console.log("on change: " + files);
    });
  });
};