express = require 'express'
bodyParser = require 'body-parser'
expressHelper = require './express_helpers'
logger = require './logger' # one time setup of the DEFAULT logger
jenkinsInterface = require './jenkins-interface'
config = require './config'

# bootstrap express
app = express()
app.use(bodyParser.json())

expressHelper.app = app

expressHelper.post('/api/jobs/create-from-template', jenkinsInterface.create_jobs)

app.listen config.port,
  () ->
    logger.ejj.misc.info 'Express server started on port %d', config.port
