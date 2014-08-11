url = require 'url'
_ = require 'lodash'
logger = require 'winston'
request = require 'request'
config = require './config'
JenkinsJob = require('./jenkins-job').JenkinsJob
require './string-ext'

# create a new job using another job as a template
copy_job_from_template = (templatePrefix, newJobPrefix, copyFrom, jenkinsUrl) ->
  logger.info 'main#copy_job_from_template',
    newJobPrefix: newJobPrefix
    copyFrom: copyFrom
    jenkinsUrl: jenkinsUrl

  newJobName = newJobPrefix + copyFrom.slice(templatePrefix.length)
  urlParams = '/createItem?name=' + newJobName + '&mode=copy&from=' + copyFrom
  createUrl = url.resolve(jenkinsUrl, urlParams)

  logger.info 'main#copy_job_from_template',
    fullUrl: createUrl

  request.post createUrl, {
    headers:
      'Content-Type': 'application/x-www-form-urlencoded'
  }, (error, response, body) ->
    logger.info 'response for copying job =>',
      error: error
      statusCode: response.statusCode

# get all jobs that start with config.expectedJobPrefix
# param: jenkinsUrl => the base url to the jenkins server
# param: templatePrefix => the prefix for the templates to search for on the server
# param: callback(jobsFound)
get_template_jobs = (jenkinsUrl, templatePrefix, callback) ->
  urlParams = '/api/json'
  requestUrl = url.resolve(jenkinsUrl, urlParams)
  logger.info 'main#get_template_jobs',
    requestUrl: requestUrl
  jobs = []
  isDone = false

  request.get {
    url: requestUrl
    json: true
  }, (error, response, body) ->
    jobsFound = []
    if (!error && response.statusCode == 200)
      _.each body.jobs, (element, index, list) ->
        logger.info 'job on Jenkins',
          index: index
          job: element
        if element.name.startsWith(templatePrefix)
          jobsFound.push new JenkinsJob(element.name, element.url)
    callback(jobsFound)

# callback for API '/api/create-jobs'
module.exports.create_jobs = (req, res) ->
  logger.info 'main#create_jobs',
    body: req.body

  jenkinsUrl = req.body.jenkinsUrl
  if _.isNull(jenkinsUrl) || _.isUndefined(jenkinsUrl)
    jenkinsUrl = config.defaultJenkinsUrl

  templatePrefix = req.body.jenkinsUrl
  if _.isNull(templatePrefix) || _.isUndefined(templatePrefix)
    templatePrefix = config.jobPrefix

  get_template_jobs jenkinsUrl, templatePrefix, (jobsFound) ->
    logger.info 'jobs found =>',
      jobs: jobsFound

    _.each jobsFound, (element, index, list) ->
      copy_job_from_template(templatePrefix, req.body.jobPrefix, element.name, jenkinsUrl)

  res.send 200
