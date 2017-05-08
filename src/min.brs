' /** 
'  * @member min
'  * @memberof module:rodash
'  * @instance
'  * @description Return the minimum of 2 numeric arguments, or invalid if one or both of them is non-numeric
'  * @example
'  *
'  * _.min(2,1)
'  * '  => 1
'  *
'  */
Function rodash_min_(a,b)
  min = invalid
  ' wrap compares in eval in case arguments are invalid or non-numeric
  result = eval("if a <= b then: min = a: else: min = b: end if")
  return min
End Function