(function() {
  var JenkinsJob, JobsRequestError, config, copy_job_from_template, get_template_jobs, jenkins, logger, request, responseCodes, url, _,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  url = require('url');

  _ = require('lodash');

  logger = require('./logger');

  request = require('request');

  config = require('./config');

  JenkinsJob = require('./jenkins-job').JenkinsJob;

  require('./string-ext');

  jenkins = require('jenkins')(config.defaultJenkinsUrl);

  responseCodes = require('./response-codes');

  JobsRequestError = (function(_super) {
    __extends(JobsRequestError, _super);

    function JobsRequestError() {}

    return JobsRequestError;

  })(Error);

  copy_job_from_template = function(templatePrefix, newJobPrefix, copyFrom, jenkinsUrl) {
    var createUrl, newJobName, urlParams;
    logger.ejj.api.info('main#copy_job_from_template', {
      newJobPrefix: newJobPrefix,
      copyFrom: copyFrom,
      jenkinsUrl: jenkinsUrl
    });
    newJobName = newJobPrefix + copyFrom.slice(templatePrefix.length);
    urlParams = '/createItem?name=' + newJobName + '&mode=copy&from=' + copyFrom;
    createUrl = url.resolve(jenkinsUrl, urlParams);
    logger.ejj.api.info('main#copy_job_from_template', {
      fullUrl: createUrl
    });
    return request.post(createUrl, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    }, function(error, response, body) {
      return logger.ejj.api.info('response for copying job =>', {
        error: error,
        statusCode: response.statusCode
      });
    });
  };

  get_template_jobs = function(jenkinsUrl, templatePrefix, callback) {
    var isDone, jobs, requestUrl, urlParams;
    urlParams = '/api/json';
    requestUrl = url.resolve(jenkinsUrl, urlParams);
    logger.ejj.api.info('main#get_template_jobs', {
      requestUrl: requestUrl
    });
    jobs = [];
    isDone = false;
    return request.get({
      url: requestUrl,
      json: true
    }, function(err, resp, body) {
      var jobsFound;
      jobsFound = [];
      if (!err && resp.statusCode === 200) {
        logger.ejj.api.info('request body :: ', {
          body: body
        });
        _.each(body.jobs, function(element, index, list) {
          var _ref;
          if (element != null ? (_ref = element.name) != null ? _ref.startsWith(templatePrefix) : void 0 : void 0) {
            return jobsFound.push(new JenkinsJob(element.name, element.url));
          }
        });
        return callback(jobsFound);
      } else {
        throw new JobsRequestError();
      }
    });
  };

  module.exports.create_jobs = function(req, res) {
    var ex, jenkinsUrl, templatePrefix;
    logger.ejj.api.info('main#create_jobs', {
      body: req.body
    });
    try {
      jenkinsUrl = req.body.jenkinsUrl;
      if (_.isNull(jenkinsUrl) || _.isUndefined(jenkinsUrl)) {
        jenkinsUrl = config.defaultJenkinsUrl;
      }
      templatePrefix = req.body.jenkinsUrl;
      if (_.isNull(templatePrefix) || _.isUndefined(templatePrefix)) {
        templatePrefix = config.jobPrefix;
      }
      get_template_jobs(jenkinsUrl, templatePrefix, function(jobsFound) {
        logger.ejj.api.info('jobs found =>', {
          jobs: jobsFound
        });
        return _.each(jobsFound, function(element, index, list) {
          return copy_job_from_template(templatePrefix, req.body.jobPrefix, element.name, jenkinsUrl);
        });
      });
      return res.send(200);
    } catch (_error) {
      ex = _error;
      res.send(500, {
        code: responseCodes.err.unknownError.code,
        type: responseCodes.err.unknownError.name
      });
      throw ex;
    }
  };

}).call(this);
