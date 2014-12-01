noop = (err, response)->
  console.log err, response
  return

conf =
  host: 'smtp.example.com'
  service: 'Mailgun'
  auth:
    user: 'user_name'
    pass: 'password'
  debug: true

_ = require("lodash")

class Mail
  constructor: (option)->

#    conf = _.extend( conf, option )
    conf = option or conf
    nodemailer = require("nodemailer")

    # create reusable transport method (opens pool of SMTP connections)
    console.log conf
    @smtpTransport = nodemailer.createTransport(conf)

  send: (data, cb)=>
    self = @
    console.log "send mail", data

    cb = noop if typeof (cb) is not "function"

    # send mail with defined transport object
    @smtpTransport.sendMail data, (error, results) ->
      cb(error, results)

      # if you don't want to use this transport object anymore, uncomment following line
      self.smtpTransport?.close() # shut down the connection pool, no more messages

module.exports = Mail