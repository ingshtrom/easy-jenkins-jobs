# global configuration for all modules
module.exports =
  # the port to listen on
  port: 1337

  # the prefix for jobs to use as templates
  jobPrefix: 'ejj_template'

  # the default Jenkins URL
  defaultJenkinsUrl: 'http://localhost:8080/'

  # default logging level
  logLevel: 'info'

  # default winston log file
  defaultLogFile: 'logs/app.log'

  # true => use loggly loggers
  useLoggly: false

  # loggly token
  logglyToken: ''

  # loggly subdomain
  logglySubdomain: ''

  # true => use logentries loggers
  useLogentries: false

  # logentries token
  logentriesToken: ''