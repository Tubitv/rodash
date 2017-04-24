' /**
'  * @member difference
'  * @memberof module:rodash
'  * @instance
'  */
Function rodash_difference_(first, second)
  result = []  
  for each f in first
    result.push(f)
    for each s in second
      if m.equal(s,f) then result.pop()
    end for
  end for
  return result
End Function