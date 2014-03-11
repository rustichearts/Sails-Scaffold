/**
 * Configure advanced options for the Express server inside of Sails.
 *
 * For more information on configuration, check out:
 * http://sailsjs.org/#documentation
 */

var url = require('url');
var parsed_url  = url.parse(process.env.REDISTOGO_URL || 'http://localhost:6379');
var parsed_auth = (parsed_url.auth || '').split(':')

module.exports.express = {


	// The middleware function used for parsing the HTTP request body.
	// (this most commonly comes up in the context of file uploads)
	//
	// Defaults to a slightly modified version of `express.bodyParser`, i.e.:
	// If the Connect `bodyParser` doesn't understand the HTTP body request 
	// data, Sails runs it again with an artificial header, forcing it to try
	// and parse the request body as JSON.  (this allows JSON to be used as your
	// request data without the need to specify a 'Content-type: application/json'
	// header)
	// 
	// If you want to change any of that, you can override the bodyParser with
	// your own custom middleware:
	// bodyParser: function customBodyParser (options) { ... },
	// 
	// Or you can always revert back to the vanilla parser built-in to Connect/Express:
	// bodyParser: require('express').bodyParser,
	// 
	// Or to disable the body parser completely:
	// bodyParser: false,
	// (useful for streaming file uploads-- to disk or S3 or wherever you like)
	//
	// WARNING
	// ======================================================================
	// Multipart bodyParser (i.e. express.multipart() ) will be removed
	// in Connect 3 / Express 4.
	// [Why?](https://github.com/senchalabs/connect/wiki/Connect-3.0)
	//
	// The multipart component of this parser will be replaced
	// in a subsequent version of Sails (after v0.10, probably v0.11) with:
	// [file-parser](https://github.com/mikermcneil/file-parser)
	// (or something comparable)
	// 
	// If you understand the risks of using the multipart bodyParser,
	// and would like to disable the warning log messages, uncomment:
	// silenceMultipartWarning: true,
	// ======================================================================



	// Cookie parser middleware to use
	//			(or false to disable)
	//
	// Defaults to `express.cookieParser`
	//
	// Example override:
	// cookieParser: (function customMethodOverride (req, res, next) {})(),



	// HTTP method override middleware
	//			(or false to disable)
	//
	// This option allows artificial query params to be passed to trick 
	// Sails into thinking a different HTTP verb was used.
	// Useful when supporting an API for user-agents which don't allow 
	// PUT or DELETE requests
	//
	// Defaults to `express.methodOverride`
	//
	// Example override:
	// methodOverride: (function customMethodOverride (req, res, next) {})()


  // Session secret is automatically generated when your new app is created
  // Replace at your own risk in production-- you will invalidate the cookies of your users,
  // forcing them to log in again.
  secret: 'cc5c32beda006d19d7609e578140e2a0',

  adapter: 'redis',
  host: parsed_url.hostname ,
  port: parsed_url.port,
  ttl: 6000,
  db: 0,
  pass: parsed_auth[1],
  prefix: 'sess:'

//  serverOptions: {
//    key: require("fs").readFileSync( require("path").resolve( "ssl/server.key" )).toString(),
//    cert: require("fs").readFileSync( require("path").resolve( "ssl/server.crt")).toString()
//  }

};