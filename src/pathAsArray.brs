''''''''''''''''
' pathAsArray
'
'  Parse an array/list or string path into discrete components.  If
'  the path segment is an assoc array key or SG node field, the array entry
'  will be a string.  If the path segment is an array index, or SG child index,
'  the array entry will be an integer.
'
Function rodash_pathAsArray_(path)
  pathRE = CreateObject("roRegex", "\[([0-9]+)\]", "i")
  segments = []
  if type(path) = "String" or type(path) = "roString"
    ' make all indexes into integers:  a[0] => a.0
    dottedPath = pathRE.replaceAll(path, ".\1")
    stringSegments = dottedPath.tokenize(".")

    ' now convert array indexes into integers
    for each s in stringSegments
      if (Asc(s) >= 48) and (Asc(s) <= 57)
        segments.push(s.toInt())
      else
        segments.push(s)
      end if
    end for

  else if type(path) = "roList" or type(path) = "roArray"
    stringPath = ""
    for each s in path
      stringPath = stringPath + "." + Box(s).toStr()
    end for
    segments = m.pathAsArray_(stringPath)

  else
    segments = invalid
  end if
  return segments
End Function
