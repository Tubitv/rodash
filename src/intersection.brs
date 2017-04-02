Function rodash_intersection_(first, second)
  result = []  
  for each f in first
    for each s in second
      if m.equal(s,f) then result.push(f)
    end for
  end for
  return result
End Function