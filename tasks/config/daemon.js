module.exports = function(gulp, plugins, growl) {

  var spawn = require("child_process").spawn;

  gulp.task("daemon:redis", function(next) {
    spawn("redis-server").stdout.on('data', function(data) {
      console.log(data.toString());
    });
    next();
  });

  gulp.task("daemon:node", function(next) {

    var r = spawn("forever", ["--verbose","--minUptime=8000", "--spinSleepTime=1000", "-d", "-w", "app.js"]);

    r.stdout.on('data', function(data) {
      if(data.toString())  console.log(data.toString());
      if (data.toString().match(/(.+)Server lifted/i)){
        return next();
      }

    });

    r.stderr.on('data', function(data) {
      if(data.toString()) console.log(data.toString());
    });
  });
};
