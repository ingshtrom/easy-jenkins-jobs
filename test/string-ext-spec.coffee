chai = require 'chai'
should = chai.should()
require '../src/string-ext'

describe 'String Extensions', () ->
  describe '#startsWith', () ->
    it 'should exist as String.prototype.startsWith after requiring module', () ->
      'foobar'.should.have.property('startsWith')
        .that.is.a('function')
    it 'startsWith returns true for valid query', () ->
      'abc'.startsWith('ab').should.be.true
    it 'startsWith returns false for invalid query', () ->
      'abc'.startsWith('bc').should.be.false
      'abc'.startsWith('xyz').should.be.false
