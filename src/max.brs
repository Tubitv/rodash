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
  min = invalid
  ' wrap compares in eval in case arguments are invalid or non-numeric
  result = eval("if a >= b then: min = a: else: min = b: end if")
  return min
End Function