Skeleton = require "#{__dirname}/../lib/skeleton"
OptionParser = require "#{__dirname}/../lib/skeleton/option_parser"
assert = require 'assert'

describe 'OptionParser', ->
  it 'finds and returns the name of the app', ->
    args = ['--force', 'myapp1', '--css', 'less']
    options = new OptionParser(args, Skeleton.OPTIONS)
    options.appName.should.equal 'myapp1'

    args = ['myapp2']
    options = new OptionParser(args, Skeleton.OPTIONS)
    options.appName.should.equal 'myapp2'

    args = ['--directory', '~/Desktop', 'myapp3']
    options = new OptionParser(args, Skeleton.OPTIONS)
    options.appName.should.equal 'myapp3'

  it 'should throw an error if flag value is not accepted', ->
    args = ['--css', 'banana']
    assert.throws ->
      new OptionParser(args, Skeleton.OPTIONS)
