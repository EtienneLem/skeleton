class OptionParser

  constructor: (@args) ->
    joinedArgs = @args.join('|')

    # TODO: Make the returned object completely dynamic
    return {
      help:     joinedArgs.search(/-h|--help/) > -1 || args.length == 0
      version:  joinedArgs.search(/-v|--version/) > -1
      renderer: this.getOptionValue ['-r', '--renderer']
      appName:  this.getOptionValue(['-a', '--appname']) || @args.last()
    }

  # Private
  # Returns given flags value or null
  getOptionValue: (flags) ->
    for flag in flags
      index = @args.indexOf(flag)
      return @args[index + 1] if index > -1

    null


# Exports
module.exports = OptionParser
