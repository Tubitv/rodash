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
'  *   signedIn: false
'  *   id: "homeScreen"
'  *   trackingPageInfo: <Component: roAssociativeArray>
'  *   ...... other common fields of node
'  * }

'  * value = _.get(data, "signedIn")
'  *
'  * value = _.get(data, "0.id") ' value of First child's id
'  *
'  * value = _.get(data, "0.1.contentMode") ' value of 1st child of 2nd child's contentMode
'  *
'  *  value = _.get(data, "trackingPageInfo.pageType")
'  *
'
'  */
Function rodash_get_(array, path, default=invalid)

if array = invalid or not (type(array) = "roAssociativeArray" or type(array) = "roArray" or type(array) = "roSGNode") then return default

  segments = m.pathAsArray_(path)
  if segments = invalid then return default

  result = array

  while segments.count() > 0
    key = segments.shift()

    if array <> invalid and GetInterface(array, "ifSGNodeChildren") <> invalid
      
      if type(key) = "roString" and array.hasField(key)
        value = array[key]
        result = result.getField(key)
      else if Type(key) = "roInt"
        if key < 0 or key >= array.getChildCount() then
          array = invalid
          exit while
        end if

        result = result.getChild(key)
      else
        result = invalid
        exit while
      end if

    else
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
    end if
  end while

  if result = invalid then return default

  return result
End Function
