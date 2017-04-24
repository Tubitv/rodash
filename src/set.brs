' /**
'  * @member set
'  * @memberof module:rodash
'  * @instance
'  */
Function rodash_set_(aa, path, value)

  if aa = invalid or type(aa) <> "roAssociativeArray" then return aa

  segments = m.pathAsArray_(path)
  if segments = invalid then return aa

  walk = aa
  while segments.count() > 0
    key = segments.shift()
    if segments.count() = 0
      walk.addReplace(key, value)
      exit while
    end if
    lookup = walk.lookup(key)
    if lookup = invalid or type(lookup) <> "roAssociativeArray"
      walk.addReplace(key, {})
    end if
    walk = walk.lookup(key)
  end while

  return aa
End Function