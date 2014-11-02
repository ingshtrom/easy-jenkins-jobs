chai = require 'chai'
should = chai.should()
JenkinsJob = require('../src/jenkins-job').JenkinsJob

describe 'JenkinsJob class', () ->
  describe 'class properties', () ->
    it 'should have a public name property', () ->
      jj = new JenkinsJob("", "")
      jj.should.have.property('name')
        .that.is.a('string')
      jj.should.have.property('url')
        .that.is.a('string')
