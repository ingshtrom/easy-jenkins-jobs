chai = require 'chai'
should = chai.should()
JenkinsJob = require '../src/jenkins-job'

describe 'JenkinsJob class', () ->
  describe 'class properties', () ->
    it 'should have a public name property'
      jj = new JenkinsJob()
      jj.should.have.property('name')
        .that.is.a('string')
      jj.should.have.property('url')
        .that.is.a('string')
    it 'should have a public url property'
    it 'should default unset variables to null'
