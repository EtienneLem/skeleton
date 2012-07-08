###
* Return last item of an array

* ['a', 'b', 'c'].last() => 'c'
###
Array::last = ->
  this[this.length - 1]

###
* Return a new copy of an array

* a = [1,2,3]
* b = a
* c = a.clone()

* a == b => true
* a == c => false
* c => [1,2,3]
###
Array::clone = ->
  for elem in this
   elem
