class OptionParser

  constructor: (@args, opts) ->
    options = {}
    for opt in opts
      short = opt[0]
      long = opt[1]
      withValue = opt[3]?
      optName = long.replace('--', '')
      options[optName] = this.getOption [short, long], withValue

    return options

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
