class OptionParser

  constructor: (@args, opts) ->
    options = {}

    for opt in opts
      short = opt[0]
      long = opt[1]
      choices = if opt[3]? then opt[3] else null
      optName = long.replace('--', '')
      options[optName] = this.getOption [short, long], choices

    options.appName = @args.last()
    return options

  # Returns given flags value if the option has choices
  # else returns a boolean if the flag is found
  getOption: (flags, choices) ->
    for flag in flags
      index = @args.indexOf(flag)
      if index > -1
        if choices?
          value = @args[index + 1]
          if choices.indexOf(value) == -1
            console.warn "Invalid value “#{value}” for #{flag} option"
            process.exit()
        else
          value = true

        this.spliceArgs index, choices?
        return value

    if choices? then choices[0] else false

  spliceArgs: (index, hasValue=false) ->
    nbr = if hasValue then 2 else 1
    @args.splice(index, nbr)


# Exports
module.exports = OptionParser
