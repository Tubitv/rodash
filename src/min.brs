Function rodash_min_(a,b)
  min = invalid
  ' wrap compares in eval in case arguments are invalid or non-numeric
  result = eval("if a <= b then: min = a: else: min = b: end if")
  return min
End Function