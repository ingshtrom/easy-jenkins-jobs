# proxyquire = require 'proxyquire'
# chai = require 'chai'
# expect = chai.expect
# requireStub = {}
# jenkinsInterface =  proxyquire '../src/jenkins-interface', {
#   'require': requireStub
# }
#
# describe 'Template Jobs', () ->
#   describe 'Querying for template jobs', () ->
#     it 'should query the correct url', (done) ->
#     it 'should return a list of templates with a valid template Prefix', (done) ->
#     it 'should return an empty list if an invalid templatePrefix is given', (done) ->
#     it 'should return an error if an invalid Jenkins server is given', (done) ->
#   describe 'Creating new jobs from copy', () ->
#     it 'should return a list of created jobs on success', (done) ->
#     it 'should return an error on failure', (done) ->
