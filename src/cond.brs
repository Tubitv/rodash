' /**
'  * @member cond
'  * @memberof module:rodash
'  * @instance
'  * @description Conditionally return something based on boolean argument.
'  *
'  * Native equivalent:
'  * ```
'  *   if true
'  *     x = 1
'  *   else
'  *     x = 2
'  *   end if
'  *```
'  *
'  * @example
'  *
'  * x = _.cond(true, 1, 2)
'  *
'  */
Function rodash_cond_(expression, t, f)
  if expression
    return t
  else
    return f
  end if
End Function