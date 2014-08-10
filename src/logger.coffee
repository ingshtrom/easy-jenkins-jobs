winston = require 'winston'
Loggly = require('winston-loggly').Loggly
Logentries = require('winston-logentries')
config = require './config'

# remove the default Console logger
winston.remove winston.transports.Console

# add our custom transports for all loggers
consoleConfig =
  level: config.logLevel
  handleExceptions: true
  colorize: true
  timestamp: true
fileConfig =
  filename: config.defaultLogFile
  level: config.logLevel
  maxsize: 102400
  handleExceptions: true
winston.loggers.options.transports = [
  new (winston.transports.Console) (consoleConfig),
  new (winston.transports.File) (fileConfig)
]

# config loggly if told to do so
if config.useLoggly
  logglyConfig =
    level: config.logLevel
    subdomain: config.logglySubdomain
    inputToken: config.logglyToken
    json: true
  winston.loggers.options.transports.push(new (Loggly) (logglyConfig))

# config logentries if told to do so
if config.useLogentries
  logentriesConfig =
    level: config.logLevel
    token: config.logentriesToken
  winston.loggers.options.transports.push(new (winston.transports.Logentries) (logentriesConfig))

# define different loggers... aka categories
# by providing this custom namespace, we have
# easy accessors to all of our custom loggers!
winston.ejj = {}

winston.loggers.add('api')
winston.ejj.api = winston.loggers.get('api')

winston.loggers.add('misc')
winston.ejj.misc = winston.loggers.get('misc')

# TODO(Alex.Hokanson): send an email when winston catches errors
winston.exitOnError = false

module.exports = winston
