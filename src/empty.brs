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