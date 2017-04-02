Function rodash_empty_(value)
  if value = invalid or m.equal(value, "")
    return true
  else if (type(value) = "roAssociativeArray" or type(value) = "roArray") and value.count() = 0
    return true
  end if
  return false
End Function