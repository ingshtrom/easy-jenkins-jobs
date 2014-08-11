(function() {
  var chai, should;

  chai = require('chai');

  should = chai.should();

  require('../src/string-ext');

  describe('String Extensions', function() {
    return describe('#startsWith', function() {
      it('should exist as String.prototype.startsWith after requiring module', function() {
        return 'foobar'.should.have.property('startsWith').that.is.a('function');
      });
      it('startsWith returns true for valid query', function() {
        return 'abc'.startsWith('ab').should.be["true"];
      });
      return it('startsWith returns false for invalid query', function() {
        'abc'.startsWith('bc').should.be["false"];
        return 'abc'.startsWith('xyz').should.be["false"];
      });
    });
  });

}).call(this);
