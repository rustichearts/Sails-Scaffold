module.exports.express ={
  serverOptions: {
    key: require("fs").readFileSync( require("path").resolve( "ssl/server.key" )).toString(),
    cert: require("fs").readFileSync( require("path").resolve( "ssl/server.crt")).toString()
  }
}