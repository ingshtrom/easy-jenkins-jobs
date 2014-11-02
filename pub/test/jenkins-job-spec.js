(function() {
  var JenkinsJob, chai, should;

  chai = require('chai');

  should = chai.should();

  JenkinsJob = require('../src/jenkins-job').JenkinsJob;

  describe('JenkinsJob class', function() {
    return describe('class properties', function() {
      return it('should have a public name property', function() {
        var jj;
        jj = new JenkinsJob("", "");
        jj.should.have.property('name').that.is.a('string');
        return jj.should.have.property('url').that.is.a('string');
      });
    });
  });

}).call(this);
