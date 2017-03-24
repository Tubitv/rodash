Function testSuite_String()
  this = BaseTestSuite()

  this.Name = "StringTestSuite"

  this.addTest("stringify", testCase_String_stringify)
  return this
End Function

Function testCase_String_stringify() As String
  testCases = [
    ' section        key               value             input type
    [ "test_types",  "boolean",        true,             "boolean" ]
    [ "test_types",  "roBoolean",      Box(true),        "roBoolean" ]
    [ "test_types",  "integer",        42%,              "integer" ]
    [ "test_types",  "roInteger",      Box(42%),         "roInt" ]
    [ "test_types",  "longinteger",    2349823492&,      "longinteger" ]
    [ "test_types",  "roLongInteger",  Box(2349823492&), "roLongInteger" ]
    [ "test_types",  "float",          243.573!,         "float" ]
    [ "test_types",  "roFloat",        Box(243.573!),    "roFloat" ]
    [ "test_types",  "double",         1.23456789D-12#,  "double" ]
    [ "test_types",  "roDouble",       Box(1.23456789D-12#),  "roDouble" ]
    [ "test_types",  "string",         "hi",             "string" ]
    [ "test_types",  "roString",       Box("hi"),        "roString" ]
    [ "test_types",  "array",          [1,2,3],          "roArray" ]
    [ "test_types",  "assocarray",     {a: 1},           "roAssociativeArray" ]
    [ "test_types",  "invalid",        invalid,          "invalid" ]
    [ "test_types",  "roInvalid",      Box(invalid),     "roInvalid" ]
  ]

  result = ""
  for each t in testCases
    result = result + m.AssertEqual(type(t[2]), t[3])
    s = Stringify(t[2])
    result = result + m.AssertEqual(type(s), "roString")
  end for 
  return result  
  
End Function