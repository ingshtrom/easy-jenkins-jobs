(function() {
  var InvalidAppError, express, logger, validateApp, _,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  _ = require('lodash');

  express = require('express');

  logger = require('./logger');

  module.exports.app = void 0;

  InvalidAppError = (function(_super) {
    __extends(InvalidAppError, _super);

    function InvalidAppError() {
      return InvalidAppError.__super__.constructor.apply(this, arguments);
    }

    return InvalidAppError;

  })(Error);

  module.exports.post = function(uri, callback) {
    validateApp(uri);
    logger.ejj.api.info("registering POST: " + uri);
    return module.exports.app.post(uri, callback);
  };

  module.exports.get = function(uri, callback) {
    validateApp(uri);
    logger.ejj.api.info("registering GET: " + uri);
    return module.exports.app.get(uri, callback);
  };

  module.exports.put = function(uri, callback) {
    validateApp(uri);
    logger.ejj.api.info("registering PUT: " + uri);
    return module.exports.app.put(uri, callback);
  };

  module.exports["delete"] = function(uri, callback) {
    validateApp(uri);
    logger.ejj.api.info("registering DELETE: " + uri);
    return module.exports.app["delete"](uri, callback);
  };

  validateApp = function(uri) {
    var app;
    app = module.exports.app;
    if (_.isUndefined(app || _.isNull(app))) {
      throw new InvalidAppError("module.exports.app was undefined or null -- cannot register endpoint. " + uri);
      return false;
    }
    return true;
  };

}).call(this);
