Function rodash_difference_(first, second)
  result = []  
  for each f in first
    for each s in second
      if not m.equal(s,f) then result.push(f)
    end for
  end for
  return result
End Function