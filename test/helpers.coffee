require "#{__dirname}/../lib/skeleton/helpers"

describe 'helpers', ->
  describe 'Array', ->
    describe '#last()', ->
      it 'should return last item of an array', ->
        ['a', 'b', 'c'].last().should.equal 'c'

    describe '#clone()', ->
      it 'should make of copy of an array', ->
        a = [1,2,3]
        b = a
        c = a.clone()

        a.should.equal b
        a.should.not.equal c

        c[0].should.equal 1
        c[1].should.equal 2
        c[2].should.equal 3
