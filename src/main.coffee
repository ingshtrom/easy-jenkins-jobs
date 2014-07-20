# The MIT License (MIT)
#
# Copyright (c) 2014, Mystic Gear Studios
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# references
url = require 'url'
_ = require 'underscore'
logger = require 'winston'
request = require 'request'
config = require './config'
JenkinsJob = require('./jenkins_job').jenkinsJob
require './string_ext'

# create a new job using another job as a template
copy_job_from_template = (newJobPrefix, copyFrom, jenkinsUrl) ->
  logger.info 'main#copy_job_from_template',
    newJobPrefix: newJobPrefix
    copyFrom: copyFrom
    jenkinsUrl: jenkinsUrl

  newJobName = newJobPrefix + copyFrom.slice(config.jobPrefix.length)
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
# param: callback(jobsFound)
get_template_jobs = (jenkinsUrl, callback) ->
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
        if element.name.startsWith(config.jobPrefix)
          jobsFound.push new JenkinsJob(element.name, element.url)
    callback(jobsFound)

# callback for API '/api/create-jobs/:id'
exports.create_jobs = (req, res) ->
  logger.info 'main#create_jobs',
    body: req.body

  jenkinsUrl = req.body.jenkinsUrl
  if _.isNull(jenkinsUrl) || _.isUndefined(jenkinsUrl)
    jenkinsUrl = config.defaultJenkinsUrl

  get_template_jobs jenkinsUrl, (jobsFound) ->
    logger.info 'jobs found =>',
      jobs: jobsFound

    _.each jobsFound, (element, index, list) ->
      copy_job_from_template(req.body.jobPrefix, element.name, jenkinsUrl)

  res.send 200
