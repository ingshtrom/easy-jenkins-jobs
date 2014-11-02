(function() {
  var app, bodyParser, config, express, expressHelper, jenkinsInterface, logger;

  express = require('express');

  bodyParser = require('body-parser');

  expressHelper = require('./express-helpers');

  logger = require('./logger');

  jenkinsInterface = require('./jenkins-interface');

  config = require('./config');

  app = express();

  app.use(bodyParser.json());

  expressHelper.app = app;

  expressHelper.post('/api/jobs/create-from-template', jenkinsInterface.create_jobs);

  app.listen(config.port, function() {
    return logger.ejj.misc.info('Express server started on port %d', config.port);
  });

}).call(this);
