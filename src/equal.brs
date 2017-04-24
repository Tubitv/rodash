' /**
'  * @member equal
'  * @memberof module:rodash
'  * @instance
'  */
'
' We don't try to compare object equivalency here, just
' for consistency with native '=' operator.  We actually can discover same nodes, but
' not same BRS native components unless they implement ifEnum and are non-empty.
'
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