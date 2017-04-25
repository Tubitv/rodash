' /**
'  * @member difference
'  * @memberof module:rodash
'  * @instance
'  * @description Return a new array of items from the first which are not in the second.
'  * @param {Array} first
'  * @param {Array} second
'  * @example
'  * 
'  * difference = _.difference([1,2], [2])
'  * ' => [1]
'  * 
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