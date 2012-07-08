class OptionParser

  ###
  * Parse command-line options

  * @param {Array}  @args
  * @param {Object} opts
  ###

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

  ###
  * Return given flags value if the option has choices
  * else return a boolean whether the flag if found or not

  * @param {Array} flags
  * @param {Array} choices
  ###

  getOption: (flags, choices) ->
    for flag in flags
      index = @args.indexOf(flag)
      if index > -1
        if choices?
          value = @args[index + 1]
          if choices.indexOf(value) == -1 && choices[0] != ''
            throw new Error "Invalid value “#{value}” for #{flag} option"
        else
          value = true

        this.spliceArgs index, choices?
        return value

    if choices? then choices[0] else false

  ###
  * When a flag if parsed, it is removed from the @args array
  * Last option remaining is the appName

  * @param {Int}     index
  * @param {Boolean} hasValue (default: false)
  ###

  spliceArgs: (index, hasValue=false) ->
    nbr = if hasValue then 2 else 1
    @args.splice(index, nbr)


# Export the class
module.exports = OptionParser
