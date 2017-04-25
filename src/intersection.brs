' /**
'  * @member intersection
'  * @memberof module:rodash
'  * @instance
'  * @description Return a new array of items from the first which are also in the second.
'  * @param {Array} first
'  * @param {Array} second
'  * @example
'  * 
'  * intersection = _.intersection([1,2], [2])
'  * ' => [2]
'  */
Function rodash_intersection_(first, second)
  result = []  
  for each f in first
    for each s in second
      if m.equal(s,f) then result.push(f)
    end for
  end for
  return result
End Function