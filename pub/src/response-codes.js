(function() {
  var ApiResponseCode;

  ApiResponseCode = (function() {
    function ApiResponseCode(name, code) {
      this.name = name;
      this.code = code;
    }

    return ApiResponseCode;

  })();

  module.exports = {
    err: {
      unknownError: new ApiResponseCode('unkown-error', 1)
    }
  };

}).call(this);
