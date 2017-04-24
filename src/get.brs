' /**
'  * @member get
'  * @memberof module:rodash
'  * @instance
'  * @description
'  *   Resolve a nested 'dot' notation path safely.  This is primarily allow things like
'  *   "myValue = a.b.c.d.e.f" to run without crashing the VM when an intermediate value is invalid.
'  */
Function rodash_get_(aa, path, default=invalid)

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
