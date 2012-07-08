{spawn, exec} = require 'child_process'

task 'test', 'run tests', ->
  shell 'NODE_ENV=test ./node_modules/.bin/mocha'

###
* Execute a shell command

* @param {String}   command
* @param {Function} callback
###

shell = (command, callback=null) ->
  exec command, (err, stdout, stderr) ->
    console.log trimStdout if trimStdout = stdout.trim()
    console.log stderr.trim() if err
    callback() if callback
