Function AssocArrayModule()
  return {
    pathAsArray_: assocArrayModule_pathAsArray_
    get: assocArrayModule_get_
    set: assocArrayModule_set_
  }
End Function


Function assocArrayModule_pathAsArray_(path)
  segments = []
  if type(path) = "String" or type(path) = "roString"
    segments = Box(path).tokenize(".")
  else if type(path) = "roList" or type(path) = "roArray"
    segments = []
    for each s in path
      segments.push(s)
    end for
  else
    segments = invalid
  end if
  return segments
End Function


'''''''''
' get()
'
' Resolve a nested 'dot' notation path safely.  This is primarily allow things like
' "myValue = a.b.c.d.e.f" to run without crashing the VM when an intermediate value is invalid.
Function assocArrayModule_get_(aa, path, default=invalid)

  if aa = invalid or type(aa) <> "roAssociativeArray" then return default

  segments = m.pathAsArray_(path)
  if segments = invalid then return default

  result = invalid
  while segments.count() > 0
    key = segments.shift()
    if not aa.doesExist(key)
      exit while
    end if
    value = aa.lookup(key)
    if segments.count() = 0
      result = value
      exit while
    end if
    if value = invalid or type(value) <> "roAssociativeArray"
      exit while
    end if
    aa = value
  end while

  if result = invalid then return default

  return result
End Function


''''''''
' set
Function assocArrayModule_set_(aa, path, value)

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