[![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com/)
![Dependencies managed by David](https://david-dm.org/ingshtrom/easy-jenkins-jobs.png)
![DevDependencies managed by David](https://david-dm.org/ingshtrom/easy-jenkins-jobs/dev-status.svg)
![Travis-CI build status](https://travis-ci.org/ingshtrom/easy-jenkins-jobs.svg)


Easy Jenkins Jobs
=================

What does EJJ Do!?
------------------
It creates a simple API to batch-create jobs in Jenkins based off of pre-defined templates on the server.  All you have to provide is the prefix for the new job(s). Optionally, you can specify the Jenkins URL as well if this isn't run on the Jenkins server itself.

Assumptions
-----------
- There are jobs on the Jenkins server that start with 'ejj_template' (this is configurable via the config.coffee file)
  - EJJ will query for all jobs with that prefix and replace it with the name specified in the POST URL


How Do I Trigger This?
--------------------
- Send a POST to http://ejj_server:1234
  - [ejj_server] is the server that EJJ is running on
- include the following in a JSON payload
  - 'templatePrefix': the prefix you will be using to search for templates on the Jenkins server.
    - this will default to config.jobPrefix if nothing is specified.  See section "What Can I Configure?"
  - 'jobPrefix': the prefix you will be using to replace 'templatePrefix' with
  - 'jenkinsUrl': the URL of the Jenkins server.  (http://jenkins:8080/)
    - this will default to config.defaultJenkinsUrl if nothing is specified.  See section "What Can I Configure?"

What Can I Configure?
---------------------
- port: (1337) the port that EJJ will listen on
- jobPrefix: ('ejj_template') the prefix of jobs that will be used as templates.  For every job found with this prefix, EJJ will create a copy of it with the passed in 'jobPrefix'.
- defaultJenkinsUrl: ('http://localhost:8080/') the url that will be used if none is specified in the JSON payload
- logLevel: ('info') the default logging level.  See [winston](https://github.com/flatiron/winston) for more information.
- defaultLogFile: ('logs/app.log') the default place to place log files.  By default log files will only get as large as 1MB until a new file is started.
- useLoggly (false) true => send logs to [Loggly](https://www.loggly.com/)
- logglyToken ('') the token for your Loggly account
- logglySubdomain ('') the subdomain for your Loggly account
- useLogentries (false) true => send logs to [Logentries](https://logentries.com/)
- logentriesToken ('') the token for your Logentries account

Getting Started
---------------
Assuming you already have [Node.js](http://nodejs.org/) and [NPM](https://www.npmjs.org/) installed, you can follow the below steps exactly.

  > git clone https://github.com/ingshtrom/easy-jenkins-jobs.git

  > cd easy-jenkins-jobs

  > npm start

And voila! The server is started and you can start sending requests to the EJJ server.

Running Tests
-------------
This will build the code AND test it.

  > npm install -g grunt-cli mocha

  > npm install

  > grunt test

Some Extra Stuff
----------------
- The pub/ directory is created from running 'grunt build'
- the node_modules/ directory was committed for your convenience. You can clone this repo and then run the app right away!
