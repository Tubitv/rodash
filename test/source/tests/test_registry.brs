Function testSuite_Registry()
  this = BaseTestSuite()
  this.Name = "RegistryModuleTestSuite"
  this.SetUp = registryTestSuite_setUp
  this.addTest("readAndWrite_types_boolean", testCase_readAndWrite_types_boolean)
  this.addTest("readAndWrite_types_integer", testCase_readAndWrite_types_integer)
  this.addTest("readAndWrite_types_longInteger", testCase_readAndWrite_types_longInteger)
  this.addTest("readAndWrite_types_float", testCase_readAndWrite_types_float)
  this.addTest("readAndWrite_types_double", testCase_readAndWrite_types_double)
  this.addTest("readAndWrite_types_string", testCase_readAndWrite_types_string)
  this.addTest("readAndWrite_types_array", testCase_readAndWrite_types_array)
  this.addTest("readAndWrite_types_assocarray", testCase_readAndWrite_types_assocarray)
  this.addTest("readAndWrite_types_invalid", testCase_readAndWrite_types_invalid)
  this.addTest("readAndWrite_case", testCase_readAndWrite_case)
  this.addTest("readAllAndWriteAll", testCase_readAllAndWriteAll)
  return this
End Function

Function registryTestSuite_setUp()
  m._ = rodash()
End Function

Function testCaseHelper_readAndWrite_types(section, key, value, readType) As String
  m._.regWrite(section, key, value)
  return m.AssertEqual(type(m._.regRead(section, key)), readType)
End Function

Function testCase_Registry_readAndWrite_types_boolean() As String
  return testCaseHelper_readAndWrite_types("test_types", "boolean", true, "roBoolean")
End Function

Function testCase_Registry_readAndWrite_types_integer() As String
  return testCaseHelper_readAndWrite_types("test_types", "integer", 42%, "roInt")
End Function

Function testCase_Registry_readAndWrite_types_longInteger() As String
  return testCaseHelper_readAndWrite_types("test_types", "longinteger", 2349823492&, "LongInteger")
End Function

Function testCase_Registry_readAndWrite_types_float() As String
  return testCaseHelper_readAndWrite_types("test_types", "float", 243.573!, "roFloat")
End Function

Function testCase_Registry_readAndWrite_types_double() As String
  return testCaseHelper_readAndWrite_types("test_types", "double", 1.23456789D-12#, "roFloat")      ' seems that roDouble can't come from JSON
End Function

Function testCase_Registry_readAndWrite_types_string() As String
  return testCaseHelper_readAndWrite_types("test_types", "string", "hi", "roString")
End Function

Function testCase_Registry_readAndWrite_types_array() As String
  return testCaseHelper_readAndWrite_types("test_types", "array", [1,2,3], "roArray")
End Function

Function testCase_Registry_readAndWrite_types_assocarray() As String
  return testCaseHelper_readAndWrite_types("test_types", "assocarray", {a: 1}, "roAssociativeArray")
End Function

Function testCase_Registry_readAndWrite_types_invalid() As String
  return testCaseHelper_readAndWrite_types("test_types", "invalid", invalid, "roInvalid")
End Function

Function testCase_Registry_readAndWrite_case() As String
  r = ""
  ' make sure two write to two different cases result in same reads
  m._.write("test_case", "Value", 1)
  r = r + m.AssertEqual(registry.read("test_case", "Value"), Box(1))
  r = r + m.AssertEqual(registry.read("test_case", "value"), Box(1))
  r = r + m.AssertEqual(registry.read("test_case", "VALUE"), Box(1))

  m._.write("test_case", "Value", 2)
  r = r + m.AssertEqual(registry.read("test_case", "Value"), Box(2))
  r = r + m.AssertEqual(registry.read("test_case", "value"), Box(2))
  r = r + m.AssertEqual(registry.read("test_case", "VALUE"), Box(2))
  return r
End Function

Function testCase_Registry_readAllAndWriteAll() As String
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

  m._.regWriteAll(data)
  read = m._.regReadAll()

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
