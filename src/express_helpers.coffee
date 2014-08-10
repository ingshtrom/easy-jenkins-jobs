_ = require 'lodash'
express = require 'express'
logger = require './logger'

# assume that the app is set here before registering any callbacks
module.exports.app = undefined

# InvalidAppError
# custom error for invalid app objects
class InvalidAppError extends Error

# register a POST endpoint
# uri - uri for the endpoint
# callback - callback function for when this api is called
module.exports.post = (uri, callback) ->
  validateApp(uri)
  logger.ejj.api.info "registering POST: #{uri}"
  module.exports.app.post(uri, callback)

# register a GET endpoint
# uri - uri for the endpoint
# callback - callback function for when this api is called
module.exports.get = (uri, callback) ->
  validateApp(uri)
  logger.ejj.api.info "registering GET: #{uri}"
  module.exports.app.get(uri, callback)

# register a PUT endpoint
# uri - uri for the endpoint
# callback - callback function for when this api is called
module.exports.put = (uri, callback) ->
  validateApp(uri)
  logger.ejj.api.info "registering PUT: #{uri}"
  module.exports.app.put(uri, callback)

# register a DELETE endpoint
# uri - uri for the endpoint
# callback - callback function for when this api is called
module.exports.delete = (uri, callback) ->
  validateApp(uri)
  logger.ejj.api.info "registering DELETE: #{uri}"
  module.exports.app.delete(uri, callback)

#####################
# PRIVATE FUNCTIONS #
#####################

validateApp = (uri) ->
  app = module.exports.app
  if _.isUndefined app || _.isNull app
    throw new InvalidAppError "module.exports.app was undefined or null -- cannot register endpoint. #{uri}"
    return false
  return true