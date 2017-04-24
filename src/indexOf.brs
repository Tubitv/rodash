' /**
'  * @member indexOf
'  * @memberof module:rodash
'  * @instance
'  */
Function rodash_indexOf_(array, value)
  if array = invalid or value = invalid or GetInterface(array, "ifArray") = invalid then return -1
  for i=0 to array.count()-1
    if m.equal(array[i], value) then return i
  end for
  return -1
End Function