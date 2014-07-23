[![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com/)


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
  - 'jobPrefix': the prefix you will be using to replace 'ejj_template' with
  - 'jenkinsUrl': the URL of the Jenkins server.  (http://jenkins:8080/)
    - this will default to 'http://localhost:8080/' if nothing is specified

What Can I Configure?
---------------------
- port: (1337) the port that EJJ will listen on
- jobPrefix: ('ejj_template') the prefix of jobs that will be used as templates.  For every job found with this prefix, EJJ will create a copy of it with the passed in 'jobPrefix'.
- defaultJenkinsUrl: ('http://localhost:8080/') the url that will be used if none is specified in the JSON payload
- logLevel: ('info') the default logging level.  See [winston](https://github.com/flatiron/winston) for more information.
- defaultLogFile: ('logs/app.log') the default place to place log files.  By default log files will only get as large as 1MB until a new file is started.

Getting Started
---------------
Assuming you already have [Node.js](http://nodejs.org/) and [NPM](https://www.npmjs.org/) installed, you can follow the below steps exactly.

  > git clone https://github.com/ingshtrom/easy-jenkins-jobs.git

  > cd easy-jenkins-jobs

  > npm install -g grunt

  > npm install

  > grunt

  > node build/index.js

And voila! The server is started and you can start sending requests to the EJJ server.

What Libraries and Tools Was This Built With?
-------------------------------------------
- [Atom.io](https://atom.io/) - Awesome text editor build on-top of Chromium with Node.js
- [MIT License](http://opensource.org/licenses/MIT) - opens source licensing
- [Node.js](http://nodejs.org/) - Javascript on the server.
- [NPM](https://www.npmjs.org/) - library management
- [Postman](http://www.getpostman.com/) - client for testing HTTP APIs
- [winston](https://github.com/flatiron/winston) - logging
- [request](https://github.com/mikeal/request) - send HTTP requests from Node.js
- [express](https://github.com/visionmedia/express) - an easy way to setup RESTful web services
- [body-parser](https://github.com/expressjs/body-parser) - a module for ExpressJS to parse 'req.body' into a JSON object
- [grunt](http://gruntjs.com/) - automated build system
- [grunt-contrib-clean](https://github.com/gruntjs/grunt-contrib-clean) - module for Grunt that allows for cleaning up generated directories
- [grunt-coffeelint](https://github.com/vojtajina/grunt-coffeelint) - module for Grunt that lints CoffeeScript code and stops the build if it fails
- [grunt-contrib-coffee](https://github.com/gruntjs/grunt-contrib-coffee) - module for Grunt that 'compiles' CoffeeScript into Javascript
