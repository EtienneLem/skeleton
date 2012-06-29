class OptionParser

  constructor: (@args) ->
    # TODO: Make the returned object completely dynamic
    return {
      help:     this.getOption(['-h', '--help']) || @args.length == 0
      version:  this.getOption ['-v', '--version']
      force:    this.getOption ['-f', '--force']
      renderer: this.getOption ['-r', '--renderer'], true
      appName:  this.getOption(['-a', '--appname'], true) || @args.last()
    }

  # Returns given flags value if `withValue`
  # else returns a boolean if the flag is found
  getOption: (flags, withValue=false) ->
    for flag in flags
      index = @args.indexOf(flag)
      if index > -1
        value = if withValue then @args[index + 1] else true
        this.spliceArgs index, withValue
        return value

    if withValue then null else false

  spliceArgs: (index, hasValue=false) ->
    nbr = if hasValue then 2 else 1
    @args.splice(index, nbr)


# Exports
module.exports = OptionParser
