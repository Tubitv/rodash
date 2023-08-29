' /**
'  * @member get
'  * @memberof module:rodash
'  * @instance
'  * @description
'  *   Resolve a nested 'dot' notation path safely.  This is primarily allow below things like
'  *   "myValue = a.b.c.d.e.f"
'  *   "myValue = node.getChild(0).id"
'  *   "myValue = node.value1.value2"
'  * to run without crashing the VM when an intermediate value is invalid.
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
'  * data = <Component: roSGNode:Group> = {
'  *   opacity: 1.0
'  *   id: "my_component"
'  *   configs: <Component: roAssociativeArray>
'  *   viewList: invalid (roArray)
'  *   ...... other common fields of node
'  * }

'  * value = _.get(data, "opacity")
'  *
'  * value = _.get(data, "0.id") ' value of data's first child's id field
'  *
'  * value = _.get(data, "0.1.color") ' value of data's first child's, second child's color field.
'  *
'  * value = _.get(data, "configs.showFeature")
'  *
'  * value = _.get(data, "viewList.0")
'
'  */
Function rodash_get_(array, path, default=invalid)

if array = invalid or not (type(array) = "roAssociativeArray" or type(array) = "roArray" or type(array) = "roSGNode") then return default

  segments = m.pathAsArray_(path)
  if segments = invalid then return default

  result = invalid

  while segments.count() > 0
    key = segments.shift()

    if type(array) = "roSGNode" and (type(key) = "roInt" or type(key) = "roInteger" or type(key) = "Integer")
      if key < 0 or key >= array.getChildCount() then
        result = invalid
        exit while
      end if

      result = array.getChild(key)
    else
      result = array[key]
    end if

    if segments.count() = 0
      exit while
    end if

    if result = invalid
      exit while
    end if

    if not (type(result) = "roAssociativeArray" or type(result) = "roArray" or type(result) = "roSGNode")
      exit while
    end if

    array = result
  end while

  if result = invalid then return default

  return result
End Function
