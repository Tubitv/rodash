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

' /**
'  * @member regRead
'  * @memberof module:rodash
'  * @instance
'  * @description Read registry at key in sectionName and deserialize from JSON string.
'  * @example
'  * 
'  * _.regRead("auth", "password")
'  * '  => "secret123abc!"
'  *
'  * _.regRead("user", "bookmarkIds")
'  * '  => [1,2,3]
'  *
'  * _.regRead("user", "settings"0
'  * '  => {a:1, b:2}
'  * 
'  */
Function rodash_regRead_(sectionName As String, key As String) As Dynamic
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

' /**
'  * @member regWrite
'  * @memberof module:rodash
'  * @instance
'  * @description Serialize value to JSON string and write to the registry at key in sectionName.
'  * @example
'  * 
'  * _.regWrite("auth", "password", "secret123abc!")
'  *
'  * _.regWrite("user", "bookmarkIds", [1,2,3])
'  *
'  * _.regWrite("user", "settings", {a:1, b:2})
'  * 
'  */
Function rodash_regWrite_(sectionName As String, key As String, value As Dynamic) As Void
  sectionName = LCase(sectionName)
  key = LCase(key)
  registry = CreateObject("roRegistry")  
  section = CreateObject("roRegistrySection", sectionName)
  section.Write(key, FormatJson(value))
  section.Flush()
  registry.Flush()
End Function

' /**
'  * @member regReadAll
'  * @memberof module:rodash
'  * @instance
'  * @description Read the entire registry for the channel.
'  * @example
'  *
'  * _.regReadAll()
'  * ' => { "section1": { "key1": "value1", "key2: "value2"}, "section2": ... }
'  *
'  *
'  */
Function rodash_regReadAll_() As Object
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

' /**
'  * @member regWriteAll
'  * @memberof module:rodash
'  * @instance
'  * @description 
'  *   Write the entire registry for the channel. By default this overwrites 
'  *   any existing data, but will not remove any sections or keys
'  *
'  * @example
'  *
'  * _.regWriteAll({ "section1": { "key1": "value1", "key2: "value2"}, "section2": ... })
'  *
'  */
Function rodash_regWriteAll_(data As Object) As Void
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
