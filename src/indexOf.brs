' /**
'  * @member indexOf
'  * @memberof module:rodash
'  * @instance
'  * @description Find the integer index of an item within an array.  Uses _.equal to test for same item.
'  * @example
'  *
'  * _.indexOf(["a","b","c"], c)
'  * '  => 2
'  */
Function rodash_indexOf_(array, value)
  if array = invalid or value = invalid or GetInterface(array, "ifArray") = invalid then return -1
  for i=0 to array.count()-1
    if m.equal(array[i], value) then return i
  end for
  return -1
End Function