Function testSuite_Registry()
  this = BaseTestSuite()

  this.Name = "RegistryModuleTestSuite"
  this.addTest("readAndWrite_types", testCase_Registry_readAndWrite_types)
  this.addTest("readAndWrite_case", testCase_Registry_readAndWrite_case)
  this.addTest("readAllAndWriteAll", testCase_Registry_readAllAndWriteAll)
  return this
End Function

Function testCase_Registry_readAndWrite_types() As String
  testCases = [
    ' section        key             value             type
    [ "test_types",  "boolean",      true,             "roBoolean" ]
    [ "test_types",  "integer",      42%,              "roInt" ]
    [ "test_types",  "longinteger",  2349823492&,      "LongInteger" ]
    [ "test_types",  "float",        243.573!,         "roFloat" ]
    [ "test_types",  "double",       1.23456789D-12#,  "roFloat" ]      ' seems that roDouble can't come from JSON
    [ "test_types",  "string",       "hi",             "roString" ]
    [ "test_types",  "array",        [1,2,3],          "roArray" ]
    [ "test_types",  "assocarray",   {a: 1},           "roAssociativeArray" ]
    [ "test_types",  "invalid",      invalid,          "roInvalid" ]
  ]

  registry = RegistryModule()
  result = ""

  for each t in testCases
    registry.write(t[0], t[1], t[2])
    r = m.AssertEqual(type(registry.read(t[0], t[1])), t[3])
    if r <> "" then print "FAIL: " + r
    result = result + r
  end for 
  return result
End Function


Function testCase_Registry_readAndWrite_case() As String
  registry = RegistryModule()
  r = ""
  ' make sure two write to two different cases result in same reads
  registry.write("test_case", "Value", 1)
  r = r + m.AssertEqual(registry.read("test_case", "Value"), Box(1))
  r = r + m.AssertEqual(registry.read("test_case", "value"), Box(1))
  r = r + m.AssertEqual(registry.read("test_case", "VALUE"), Box(1))

  registry.write("test_case", "Value", 2)
  r = r + m.AssertEqual(registry.read("test_case", "Value"), Box(2))
  r = r + m.AssertEqual(registry.read("test_case", "value"), Box(2))
  r = r + m.AssertEqual(registry.read("test_case", "VALUE"), Box(2))
  return r
End Function

Function testCase_Registry_readAllAndWriteAll() As String
  registry = RegistryModule()

  data = {
    "section1": {
      "key1": 1
      "key2": 2
      "key3": 3
    }
    "section2": {
      "key4": "4"
      "key5": [1,2,3]
      "key6": {a:1,b:2}
    }
    "section3": {
      "key7": Box("7")          ' non-intrinsic types
      "key8": [ {a: 1},{b:2}]   ' nested types
      "key9": { x: [1,2,3] }
    }
  }

  registry.writeAll(data)
  read = registry.readAll()

  r = ""
  for each section in data
    r = r + m.AssertNotInvalid(read[section])
    for each key in data[section]
      r = r + m.AssertEqual(type(read[section][key]), type(Box(data[section][key])))
      ' We could recurse further for complex types but this good for now
    end for
  end for
  return r
End Function
