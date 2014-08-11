(function() {
  var Logentries, Loggly, config, consoleConfig, fileConfig, logentriesConfig, logglyConfig, winston;

  winston = require('winston');

  Loggly = require('winston-loggly').Loggly;

  Logentries = require('winston-logentries');

  config = require('./config');

  winston.remove(winston.transports.Console);

  consoleConfig = {
    level: config.logLevel,
    handleExceptions: true,
    colorize: true,
    timestamp: true
  };

  fileConfig = {
    filename: config.defaultLogFile,
    level: config.logLevel,
    maxsize: 102400,
    handleExceptions: true
  };

  winston.loggers.options.transports = [new winston.transports.Console(consoleConfig, new winston.transports.File(fileConfig))];

  if (config.useLoggly) {
    logglyConfig = {
      level: config.logLevel,
      subdomain: config.logglySubdomain,
      inputToken: config.logglyToken,
      json: true
    };
    winston.loggers.options.transports.push(new Loggly(logglyConfig));
  }

  if (config.useLogentries) {
    logentriesConfig = {
      level: config.logLevel,
      token: config.logentriesToken
    };
    winston.loggers.options.transports.push(new winston.transports.Logentries(logentriesConfig));
  }

  winston.ejj = {};

  winston.loggers.add('api');

  winston.ejj.api = winston.loggers.get('api');

  winston.loggers.add('misc');

  winston.ejj.misc = winston.loggers.get('misc');

  winston.exitOnError = false;

  module.exports = winston;

}).call(this);
