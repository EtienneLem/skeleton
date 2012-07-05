# Node.js dependencies
fs = require 'fs'
path = require 'path'
util = require 'util'
mkdirp = require 'mkdirp'
colors = require 'colors'

# Local dependencies
Template = require './template'
OptionParser = require './option_parser'

# Helpers
require './helpers'

# Main class
class Skeleton

  @VERSION = '0.0.1'

  @OPTIONS = [
  #  Short Long           Description                     Choices
    ['-h', '--help',      'display this help message'                               ]
    ['-v', '--version',   'display the version number'                              ]
    ['-f', '--force',     'force on non-empty directory'                            ]
    ['-r', '--renderer',  'template engine',              ['ejs', 'jade']           ]
    ['-c', '--css',       'stylesheet engine',            ['stylus', 'less', 'css'] ]
    ['-j', '--js',        'javascript engine',            ['coffee', 'js']          ]
  ]

  # Bin command
  constructor: ->
    @folderCache = {}

    args = process.argv.splice(2)
    options = new OptionParser(args, Skeleton.OPTIONS)

    if options.help || args.length == 0
      this.displayHelp()
      return

    if options.version
      this.displayVersion()
      return

    if options.appName
      files = fs.readdir "./#{options.appName}", (err, files) =>
        throw err if err && 'ENOENT' != err.code
        empty = !files?.length > 0

        if empty || !empty && options.force
          this.createProject(options.appName, options)
        else
          this.displayLine 'Folder not empty. Use the --force flag to overrite'.grey
          this.displayLine "#{'$'.cyan} skeleton -f #{options.appName}"

  createProject: (appName, opts) =>
    template = new Template(appName, opts)
    this.displayLine ''

    for filename, content of template.files
      this.write filename, "#{content}\n"

    this.displayLine ''
    this.displayLine '  ============================================='.cyan
    this.displayLine "  #{'template engine:'.cyan} #{opts.renderer}"
    this.displayLine "  #{'stylesheet engine:'.cyan} #{opts.css}"
    this.displayLine "  #{'javascript engine:'.cyan} #{opts.js}"
    this.displayLine ''
    this.displayLine "  #{'$'.cyan} cd #{opts.appName} && npm install"
    this.displayLine "  #{'$'.cyan} node server.js"
    this.displayLine '  ============================================='.cyan

  write: (path, content) ->
    this.mkdir path, (spaces) =>
      return if path.split('/').pop() == 'empty'

      fs.writeFileSync path, content
      this.displayLine "  #{spaces}create: #{path}"

  mkdir: (filename, callback=null) ->
    dirname = path.dirname(filename)
    depth = dirname.split('/').length
    spaces = new Array(depth).join('')

    if @folderCache[dirname]
      callback(spaces) if callback
      return

    mkdirp.sync dirname, '0755'
    @folderCache[dirname] = true

    this.displayLine "  #{spaces}create: #{dirname}".magenta
    callback(spaces) if callback

  # Display messages
  displayHelp: ->
    rules = []
    longest = 0

    for option in Skeleton.OPTIONS
      short = option[0]
      long = option[1]
      desc = option[2]
      choices = option[3]

      length = short.length + long.length
      longest = length if length > longest

      rules.push
        short: short
        long: long
        desc: desc
        choices: choices
        length: length

    this.displayLine '\n  Usage: skeleton [options] myapp\n'

    for rule in rules
      spaces = new Array(longest - rule.length + 3).join(' ')
      this.displayLine "  #{rule.short}, #{rule.long}#{spaces}#{rule.desc} #{this.printChoices rule.choices}"

  printChoices: (choices) ->
    return '' if !choices

    "[#{choices.join(', ')}] (default: #{choices[0]})"

  displayVersion: ->
    this.displayLine "Skeleton version #{Skeleton.VERSION}"

  displayLine: (line) ->
    process.stdout.write "#{line}\n"


# Exports
module.exports = Skeleton
