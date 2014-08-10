# represents a Jenkins Job returned from the /api/json API
module.exports.jenkinsJob = class JenkinsJob
  # default constructor
  constructor: (@name, @url) ->

  # get the name of the job
  getName: -> @name

  # get the url of the job
  getUrl: -> @url
