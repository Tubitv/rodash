' /**
'  * @member empty
'  * @memberof module:rodash
'  * @instance
'  * @description Test for a string, array, or object to be invalid, length, or count of zero.
'  * @example
'  *
'  * _.empty(invalid))
'  * '  => true
'  *
'  * _.empty(""))
'  * '  => true
'  *
'  * _.empty("abc"))
'  * '  => false
'  *
'  * _.empty({}))
'  * '  => true
'  *
'  * _.empty({a:1}))
'  * '  => false
'  *
'  * _.empty([]))
'  * '  => true
'  *
'  */
Function rodash_empty_(value)
  if value = invalid then return true
  if GetInterface(value, "ifAssociativeArray") <> invalid
    return (value.count() = 0)
  else if GetInterface(value, "ifArray") <> invalid
    return (value.count() = 0)
  else if (type(value) = "roString") or (type(value) = "String")
    return (value = "")  ' works for native and object strings
  end if
  return false
End Function