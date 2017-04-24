' /**
'  * @member map
'  * @memberof module:rodash
'  * @instance
'  */
Function rodash_map_(object, fn)
  if type(fn) <> "Function"
    fn = Function(x): return x: End FUnction
  end if
  if GetInterface(object, "ifArray") <> invalid
    result = []
    for each o in object
      result.push(fn(o))
    end for
    return result
  else
    return []
  end if
End Function