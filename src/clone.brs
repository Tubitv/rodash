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

' Only clones the fields. Children will remain on the source node
Function rodash_clone_(source)
  if source <> invalid 
    if type(source) = "roSGNode"
      return m.cloneNode_(source)
    else if type(source) = "roAssociativeArray"
      return m.cloneAssocArray_(source)
    end if
  end if
  return invalid
End Function

Function rodash_cloneDeep_(source)
  newTree = m.clone(source)
  for i=0 to source.getChildCount()-1
    newTree.appendChild(m.cloneDeep(source.getChild(i)))
  end for
  return newTree
End Function