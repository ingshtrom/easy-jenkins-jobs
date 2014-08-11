(function() {
  var JenkinsJob;

  module.exports.JenkinsJob = JenkinsJob = (function() {
    function JenkinsJob(name, url) {
      this.name = name;
      this.url = url;
    }

    JenkinsJob.prototype.getName = function() {
      return this.name;
    };

    JenkinsJob.prototype.getUrl = function() {
      return this.url;
    };

    return JenkinsJob;

  })();

}).call(this);
