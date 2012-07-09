fs = require 'fs'

# Recursively require a folder’s files
exports.autoload = autoload = (dir, app) ->
  fs.readdirSync(dir).forEach (file) ->
    path = "#{dir}/#{file}"
    stats = fs.lstatSync(path)

    # Go through the loop again if it is a directory
    if stats.isDirectory()
      autoload path, app
    else
      require(path)?(app)

# Return last item of an array
# ['a', 'b', 'c'].last() => 'c'
Array::last = ->
  this[this.length - 1]

# Capitalize a string
# string => String
String::capitalize = () ->
    this.replace /(?:^|\s)\S/g, (a) -> a.toUpperCase()

# Classify a string
# application_controller => ApplicationController
String::classify = (str) ->
  classified = []
  words = str.split('_')
  for word in words
    classified.push word.capitalize()

  classified.join('')
