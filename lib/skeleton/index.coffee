# Node.js dependencies
fs = require 'fs'
path = require 'path'
util = require 'util'
mkdirp = require 'mkdirp'

# Local dependencies
Template = require './template'
OptionParser = require './option_parser'

# Helpers
require './helpers'

# Main class
class Skeleton

  @VERSION = '0.0.1'

  @OPTIONS = [
    ['-h', '--help', 'display this help message']
    ['-v', '--version', 'display the version number']
    ['-r', '--renderer', 'use specified renderer [only ejs for now]']
  ]

  # Bin command
  constructor: ->
    @folderCache = {}

    args = process.argv.splice(2)
    options = new OptionParser(args)

    if options.help
      this.displayHelp()
      return

    if options.version
      this.displayVersion()
      return

    this.createProject(options.appName, options) if options.appName

  createProject: (appName, opts) =>
    template = new Template(appName, opts)
    for filename, content of template.files
      this.write filename, "#{content}\n"

  write: (path, content) ->
    this.mkdir path, =>
      return if path.split('/').pop() == 'empty'

      fs.writeFileSync path, content
      this.displayLine "=> Create #{path}"

  mkdir: (filename, callback=null) ->
    dirname = path.dirname(filename)
    if @folderCache[dirname]
      callback() if callback
      return

    mkdirp.sync dirname, '0755'
    @folderCache[dirname] = true

    this.displayLine "=> Create #{dirname}"
    callback() if callback

  # Display messages
  displayHelp: ->
    rules = []
    longest = 0

    for option in Skeleton.OPTIONS
      short = option[0]
      long = option[1]
      desc = option[2]

      length = short.length + long.length
      longest = length if length > longest

      rules.push
        short: short
        long: long
        desc: desc
        length: length

    this.displayLine '\nUsage: skeleton [options] myapp\n'

    for rule in rules
      spaces = new Array(longest - rule.length + 3).join(' ')
      this.displayLine "#{rule.short}, #{rule.long}#{spaces}#{rule.desc}"

  displayVersion: ->
    this.displayLine "Skeleton version #{Skeleton.VERSION}"

  displayLine: (line) ->
    process.stdout.write "#{line}\n"


# Exports
module.exports = Skeleton
