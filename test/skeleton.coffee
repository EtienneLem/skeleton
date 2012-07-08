Skeleton = require "#{__dirname}/../lib/skeleton"
OptionParser = require "#{__dirname}/../lib/skeleton/option_parser"

fs = require 'fs'
assert = require 'assert'
rimraf = require 'rimraf'

describe 'skeleton', ->
  appName = 'myapp'
  dir = "./test"
  path = "#{dir}/#{appName}"
  defaultArgs = ['myapp', '--directory', dir, '--nolog']

  describe 'generator', ->
    afterEach ->
      if fs.existsSync path
        rimraf.sync path

    it 'creates a folder', (done) ->
      new Skeleton defaultArgs.clone(), ->
        fs.existsSync(path).should.equal true
        done()

    describe 'template engine', ->
      it 'uses ejs (default)', (done) ->
        new Skeleton defaultArgs.clone(), ->
          fs.existsSync("#{path}/app/views/index.ejs").should.equal true
          done()

      it 'uses jade', (done) ->
        new Skeleton defaultArgs.clone().concat(['--renderer', 'jade']), ->
          fs.existsSync("#{path}/app/views/index.jade").should.equal true
          done()

      it 'uses haml (TODO)'

    describe 'css engine', ->
      it 'uses stylus (default)', (done) ->
        new Skeleton defaultArgs.clone(), ->
          fs.existsSync("#{path}/app/assets/css/styles.styl").should.equal true
          done()

      it 'uses less', (done) ->
        new Skeleton defaultArgs.clone().concat(['--css', 'less']), ->
          fs.existsSync("#{path}/app/assets/css/styles.less").should.equal true
          done()

      it 'uses sass (TODO)'

      it 'uses css', (done) ->
        new Skeleton defaultArgs.clone().concat(['--css', 'css']), ->
          fs.existsSync("#{path}/app/assets/css/styles.css").should.equal true
          done()

    describe 'js engine', ->
      it 'uses coffeescript (default)', (done) ->
        new Skeleton defaultArgs.clone(), ->
          fs.existsSync("#{path}/app/assets/js/scripts.coffee").should.equal true
          done()

      it 'uses javascript', (done) ->
        new Skeleton defaultArgs.clone().concat(['--js', 'js']), ->
          fs.existsSync("#{path}/app/assets/js/scripts.js").should.equal true
          done()
