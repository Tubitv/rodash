' /**
'  * @member get
'  * @memberof module:rodash
'  * @instance
'  * @description
'  *   Resolve a nested 'dot' notation path safely.  This is primarily allow things like
'  *   "myValue = a.b.c.d.e.f" to run without crashing the VM when an intermediate value is invalid.
'  *
'  * @example
'  *
'  * data = { a: 1 b: { c: 2 d: { e: 3 f: [4, 5] } } }
'  * value = _.get(data, ["b","d","f"])
'  * '  => [4, 5]
'  *
'  * value = _.get(data, "b.d.f[0]")
'  * '  => 4
'  *
'  * value = _.get(data, "a[0]")
'  * '  => invalid
'  *
'  */
Function rodash_get_(array, path, default=invalid)

if array = invalid or not (type(array) = "roAssociativeArray" or type(array) = "roArray") then return default

  segments = m.pathAsArray_(path)
  if segments = invalid then return default

  result = invalid
  while segments.count() > 0
    key = segments.shift()
    value = array[key]
    if value = invalid
      exit while
    end if
    if segments.count() = 0
      result = value
      exit while
    end if
    if not (type(value) = "roAssociativeArray" or type(value) = "roArray")
      exit while
    end if
    array = value
  end while

  if result = invalid then return default

  return result
End Function
