' /**
'  * @member equal
'  * @memberof module:rodash
'  * @instance
'  * @description Enhance the native '=' operator by catching type mismatch errors.
'  * @example
'  *
'  * _.equal(invalid, "a")
'  * '  => false
'  *
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
  ' These types will always compare to false or fail comparison with runtime errors
  all = {
    "rosgnode": true
    "rofunction": true
    "invalid": true
    "roarray": true
    "roassociativearray": true
  }
  ' Key-value pairs which will cause runtime errors if comparisons attempted
  incomparable = {
    "string": {
      "integer": true
      "rointeger": true
      "boolean": true
      "roboolean": true
      "roarray": true
      "roassociativearray": true
      "longinteger": true
      "rofloat": true
    }
    "rostring": {
      "integer": true
      "rointeger": true
      "boolean": true
      "roboolean": true
      "roarray": true
      "roassociativearray": true
      "longinteger": true
      "rofloat": true
    }
  }
  atype = lcase(type(a))
  btype = lcase(type(b))
  if all[atype] = invalid and all[btype] = invalid
    if incomparable[lcase(type(a))] = invalid or incomparable[lcase(type(a))][lcase(type(b))] = invalid 
      if incomparable[lcase(type(b))] = invalid or incomparable[lcase(type(b))][lcase(type(a))] = invalid
        if a = b
          return true
        else if type(a) = type(b) and type(a) = invalid 
          return true
        end if
      end if
    end if
  end if
  return false
End Function
