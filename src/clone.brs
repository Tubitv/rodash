' Only clones the fields. Children will remain on the source node
Function rodash_cloneNode_(source)
  blacklistedFields = ["change", "focusedChild"]  ' read-only fields
  destination = CreateObject("roSGNode", source.subtype())
  fields = source.getFields()
  for each f in blacklistedFields
    fields.delete(f)
  end for
  destination.setFields(fields)
  return destination
End Function

Function rodash_cloneAssocArray_(source)
  destination = {}
  for each key in source
    destination[key] = source[key]
  end for
  return destination
End Function


' Any type that supports ifArray:
'  roArray
'  roByteArray
'  roList
'  roXMLList
'
Function rodash_cloneArrayish_(source)
  if type(source) = "roArray"
    destination = CreateObject(type(source), 0, true)
  else
    destination = CreateObject(type(source))
  end if
  destination.Append(source)
  return destination
End Function


Function rodash_cloneStringish_(source)
  destination = CreateObject("roString")
  destination.SetString(source.GetString())
  if type(source) = "roString"
    return destination
  else if type(source) = "String"
    return destination.GetString()
  end if
End Function


' /**
'  * @member clone
'  * @memberof module:rodash
'  * @instance
'  */
Function rodash_clone_(source)
  if source <> invalid 
    if type(source) = "roSGNode"
      return m.cloneNode_(source)
    else if type(source) = "roAssociativeArray"
      return m.cloneAssocArray_(source)
    else if GetInterface(source, "ifArray") <> invalid
      return m.cloneArrayish_(source)
    else if (type(source) = "roString") or (type(source) = "String")
      return m.cloneStringish_(source)
    else
      ' TODO: test if boxed vs. native types can be cloned
      '       by simply returning them here
    end if
  end if
  return invalid
End Function

' /**
'  * @member cloneDeep
'  * @memberof module:rodash
'  * @instance
'  */
Function rodash_cloneDeep_(source)
  newTree = m.clone(source)
  for i=0 to source.getChildCount()-1
    newTree.appendChild(m.cloneDeep(source.getChild(i)))
  end for
  return newTree
End Function
