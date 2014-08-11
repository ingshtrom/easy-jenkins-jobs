(function() {
  var JenkinsJob, config, copy_job_from_template, get_template_jobs, logger, request, url, _;

  url = require('url');

  _ = require('lodash');

  logger = require('winston');

  request = require('request');

  config = require('./config');

  JenkinsJob = require('./jenkins-job').JenkinsJob;

  require('./string-ext');

  copy_job_from_template = function(templatePrefix, newJobPrefix, copyFrom, jenkinsUrl) {
    var createUrl, newJobName, urlParams;
    logger.info('main#copy_job_from_template', {
      newJobPrefix: newJobPrefix,
      copyFrom: copyFrom,
      jenkinsUrl: jenkinsUrl
    });
    newJobName = newJobPrefix + copyFrom.slice(templatePrefix.length);
    urlParams = '/createItem?name=' + newJobName + '&mode=copy&from=' + copyFrom;
    createUrl = url.resolve(jenkinsUrl, urlParams);
    logger.info('main#copy_job_from_template', {
      fullUrl: createUrl
    });
    return request.post(createUrl, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    }, function(error, response, body) {
      return logger.info('response for copying job =>', {
        error: error,
        statusCode: response.statusCode
      });
    });
  };

  get_template_jobs = function(jenkinsUrl, templatePrefix, callback) {
    var isDone, jobs, requestUrl, urlParams;
    urlParams = '/api/json';
    requestUrl = url.resolve(jenkinsUrl, urlParams);
    logger.info('main#get_template_jobs', {
      requestUrl: requestUrl
    });
    jobs = [];
    isDone = false;
    return request.get({
      url: requestUrl,
      json: true
    }, function(error, response, body) {
      var jobsFound;
      jobsFound = [];
      if (!error && response.statusCode === 200) {
        _.each(body.jobs, function(element, index, list) {
          logger.info('job on Jenkins', {
            index: index,
            job: element
          });
          if (element.name.startsWith(templatePrefix)) {
            return jobsFound.push(new JenkinsJob(element.name, element.url));
          }
        });
      }
      return callback(jobsFound);
    });
  };

  module.exports.create_jobs = function(req, res) {
    var jenkinsUrl, templatePrefix;
    logger.info('main#create_jobs', {
      body: req.body
    });
    jenkinsUrl = req.body.jenkinsUrl;
    if (_.isNull(jenkinsUrl) || _.isUndefined(jenkinsUrl)) {
      jenkinsUrl = config.defaultJenkinsUrl;
    }
    templatePrefix = req.body.jenkinsUrl;
    if (_.isNull(templatePrefix) || _.isUndefined(templatePrefix)) {
      templatePrefix = config.jobPrefix;
    }
    get_template_jobs(jenkinsUrl, templatePrefix, function(jobsFound) {
      logger.info('jobs found =>', {
        jobs: jobsFound
      });
      return _.each(jobsFound, function(element, index, list) {
        return copy_job_from_template(templatePrefix, req.body.jobPrefix, element.name, jenkinsUrl);
      });
    });
    return res.send(200);
  };

}).call(this);
