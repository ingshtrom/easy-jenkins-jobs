# extend with a better version of startsWith(str)
# http://stackoverflow.com/questions/646628/how-to-check-if-a-string-startswith-another-string
if typeof String.prototype.startsWith != 'function'
  String.prototype.startsWith = (str) ->
    this.slice(0, str.length) == str
