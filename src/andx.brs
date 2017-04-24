' /** 
'  * @member andx
'  * @memberof module:rodash
'  * @instance
'  * @description Test all argument as boolean and return the result.  Primary goal is to allow mult-line and statements.
'  * @example
'  *
'  * if _.andx([
'  *   test1
'  *   test2 = invalid
'  *   test3 = 6])
'  *   print "true"
'  * else
'  *   print "false"
'  * end if
'  */
Function rodash_andx_(args)
  for each a in args
    if not a then return false
  end for
  return true
End Function