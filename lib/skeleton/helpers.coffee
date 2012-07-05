###
* Return last item of an array
* ['a', 'b', 'c'].last() => 'c'
###
Array::last = ->
  this[this.length - 1]
