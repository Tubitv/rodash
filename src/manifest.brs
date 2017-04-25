' /**
'  * @member getManifest
'  * @memberof module:rodash
'  * @instance
'  * @description
'  *   Read and parse the manifest file manually in order to
'  *   retrieve all key/value pairs.
'  *   Manifest is always at pkg:/manifest, but can be overridden for testing
'  *
'  * @example
'  *
'  * _.getManifest()
'  * '  => { "title": "My Channel", ... }
'  */
Function rodash_getManifest_(path="pkg:/manifest" As String)
  file = ReadAsciiFile(path)
  lines = file.split(Chr(10))
  manifest = {}
  for each line in lines
    line = line.trim()
    if line.left(1) <> "#" and line.len() <> 0 then
      equal = line.instr(0, "=")
      if equal = -1 then equal = line.len()
      key = line.left(equal)
      value = line.mid(equal+1)
      manifest[key] = value
    end if
  end for
  return manifest
End Function
