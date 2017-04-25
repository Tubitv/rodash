' /**
'  * @member map
'  * @memberof module:rodash
'  * @instance
'  * @description Execute a function over all items of an object, collecting the results into an array.
'  * @example
'  *
'  * _.map([1,2,3], Function(x): return x*x: End Function)
'  * '  => [1,4,9]
'  * 
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