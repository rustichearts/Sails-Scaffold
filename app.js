require("./node_modules/sails/node_modules/coffee-script");

// Start sails and pass it command line arguments
require('sails').lift(require('optimist').argv);
