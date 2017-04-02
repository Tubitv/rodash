' We don't try to compare object equivalency here, just
' for consistency.  We can discover same nodes, but
' not same BRS native components.  We can use ifEnum to
' discover same array/list/assocarray, but it only works
' if they are not empty.

' Behavior:
'  - number types are coerced to boolean when tested against a boolean, except for double which coerces to false
'
'
Function rodash_equal_(a, b)
  compare = false
  result = eval("if a = b then compare = true")
  if not compare
    if type(a) = type(b)
      if type(a) = invalid 
        compare = true
      end if
    end if
  end if
  return compare
End Function