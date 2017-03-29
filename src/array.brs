Function ArrayModule()
  return {
    intersection: arrayModule_intersection_
    equal: arrayModule_equal_
  }
End Function

Function arrayModule_intersection_(first, second)
  result = []  
  for each f in first
    for each s in second
      if m.equal(s,f) then result.push(f)
    end for
  end for
  return result
End Function


Function arrayModule_equal_(a, b)
  compare = false
  result = eval("if a = b then compare = true")
  if not compare
    if type(a) = type(b)
      if type(a) = invalid 
        compare = true
      else if type(a) = "roSGNode"
        compare = a.isSameNode(b)
      else
        ' how do we compare two objects for sameness?
      end if
    end if
  end if
  return compare
End Function