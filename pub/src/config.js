(function() {
  module.exports = {
    port: 1337,
    jobPrefix: 'ejj_template',
    defaultJenkinsUrl: 'http://localhost:8080/',
    logLevel: 'info',
    defaultLogFile: 'logs/app.log',
    useLoggly: false,
    logglyToken: '',
    logglySubdomain: '',
    useLogentries: false,
    logentriesToken: ''
  };

}).call(this);
