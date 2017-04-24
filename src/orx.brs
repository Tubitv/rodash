' /** 
'  * @member orx
'  * @memberof module:rodash
'  * @instance
'  * @description Test each argument as boolean and return the result.  Primary goal is to allow mult-line or statements.
'  * @example
'  *
'  * if _.orx([
'  *    test1
'  *    test2 = invalid
'  *    test3 = 6]) and test4 <> invalid
'  *    print "true"
'  *  else
'  *    print "false"
'  * end if
'  */
Function rodash_orx_(args)
  for each a in args
    if a then return true
  end for
  return false
End Function