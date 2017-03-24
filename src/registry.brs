' Use JSON formatting to serialize and deserialize values to the registry
'
' Tested with the following Brightscript types:
'   Boolean
'   Integer
'   LongInteger
'   Float
'   Double
'   String
'   Object
'   Invalid
'
' Example console output:
'
'   Brightscript Debugger> print type(ParseJson(FormatJson(invalid)))
'   roInvalid
'
' NOTE! That registry entries are case-sensitive.  We force lowercase for all section and key names to avoid problems.
'
Function RegistryModule()
  return {
    ' public methods
    read: registryModule_read_
    write: registryModule_write_

    readAll: registryModule_readAll_
    writeAll: registryModule_writeAll_
  }
End Function


'''''''''''
' read()
'
' Read and deserialize to a native type
Function registryModule_read_(sectionName As String, key As String) As Dynamic
  sectionName = LCase(sectionName)
  key = LCase(key)
  registry = CreateObject("roRegistry")  
  section = CreateObject("roRegistrySection", sectionName)
  if section.Exists(key) then
    return ParseJson(section.Read(key))
  else
    return invalid
  end if
End Function


'''''''''''
' write()
Function registryModule_write_(sectionName As String, key As String, value As Dynamic) As Void
  sectionName = LCase(sectionName)
  key = LCase(key)
  registry = CreateObject("roRegistry")  
  section = CreateObject("roRegistrySection", sectionName)
  section.Write(key, FormatJson(value))
  section.Flush()
  registry.Flush()
End Function


'''''''''
' readAll()
Function registryModule_readAll_() As Object
  registry = CreateObject("roRegistry")
  sections = registry.GetSectionList()
  data = {}
  for each sectionName in sections
    section = CreateObject("roRegistrySection", sectionName)
    keys = section.GetKeyList()
    sectionData = {}
    for each k in keys
      sectionData[k] = ParseJson(section.Read(k))
    end for
    data[sectionName] = sectionData
  end for
  return data
End Function

'''''''''
' writeAll()
'
' By default this overwrites any existing data, but will not remove any sections or keys
Function registryModule_writeAll_(data As Object) As Void
  registry = CreateObject("roRegistry")
  if data <> invalid and type(data) = "roAssociativeArray" then
    for each sectionName in data
      sectionData = data[sectionName]
      sectionName = LCase(Box(sectionName.toStr())) ' force it to a roString
      section = CreateObject("roRegistrySection", sectionName)
      if sectionData <> invalid and type(sectionData) = "roAssociativeArray" then
        for each key in sectionData
          value = sectionData[key]
          key = LCase(Box(key.toStr()))
          section.Write(key, FormatJson(value))
        end for
      end if
      section.Flush()
    end for
  end if
  registry.Flush()
End Function


