class ApiResponseCode
  constructor: (@name, @code) ->

module.exports =
  err:
    unknownError: new ApiResponseCode('unkown-error', 1)
