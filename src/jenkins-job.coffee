# represents a Jenkins Job returned from the /api/json API
module.exports.JenkinsJob = class JenkinsJob
  # default constructor
  constructor: (@name, @url) ->
