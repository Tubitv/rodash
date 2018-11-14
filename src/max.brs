' /** 
'  * @member max
'  * @memberof module:rodash
'  * @instance
'  * @description Return the maximum of 2 numeric arguments, or invalid if one or both of them is non-numeric
'  * @example
'  *
'  * _.max(2,1)
'  * '  => 2
'  *
'  */
Function rodash_max_(a,b)
  comparable = [
    "integer"
    "rointeger"
    "roint"
    "float"
    "rofloat"
    "double"
    "rodouble"
  ]
  for i=0 to comparable.count()-1
    if lcase(type(a)) = comparable[i]
      exit for
    end if
  end for
  if i = comparable.count()
    return b
  end if

  for j=0 to comparable.count()-1
    if lcase(type(b)) = comparable[j]
      exit for
    end if
  end for
  if j = comparable.count()
    return a
  end if

  if a >= b
    return a
  else
    return b
  end if
End Function
