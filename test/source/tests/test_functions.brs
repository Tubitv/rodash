Function testSuite_Functions()
  this = BaseTestSuite()

  this.Name = "FunctionsTestSuite"

  this.addTest("functionsExplicitParams", testCase_Functions_functionsExplicitParams)
  this.addTest("functionsExplicitParams_wrongTypeObject", testCase_Functions_functionsExplicitParams_wrongTypeObject)
  this.addTest("functionsExplicitParams_wrongTypeString", testCase_Functions_functionsExplicitParams_wrongTypeString)
  this.addTest("functionsExplicitParams_wrongTypeInteger", testCase_Functions_functionsExplicitParams_wrongTypeInteger)
  this.addTest("functionsExplicitParams_wrongTypeDynamic", testCase_Functions_functionsExplicitParams_wrongTypeDynamic)
  this.addTest("functionsDynamicParams", testCase_Functions_functionsDynamicParams)
  this.addTest("functionsDynamicParams_wrongTypeObject", testCase_Functions_functionsDynamicParams_wrongTypeObject)
  this.addTest("functionsDynamicParams_wrongTypeString", testCase_Functions_functionsDynamicParams_wrongTypeString)
  this.addTest("functionsDynamicParams_wrongTypeInteger", testCase_Functions_functionsDynamicParams_wrongTypeInteger)
  this.addTest("functionsDynamicParams_wrongTypeDynamic", testCase_Functions_functionsDynamicParams_wrongTypeDynamic)
  this.addTest("functionsBareParams", testCase_Functions_functionsBareParams)
  this.addTest("functionsBareParams_wrongType", testCase_Functions_functionsBareParams_wrongType)
  return this
End Function


''''''''''''''''''''''''''
' functionsExplicitParams
''''''''''''''''''''''''''
Function testCase_Functions_functionsExplicitParams()
  return m.AssertTrue(functionsExplicitParams({}, "b", 1, invalid))
End Function

Function testCase_Functions_functionsExplicitParams_wrongTypeObject()
  return m.AssertFalse(functionsExplicitParams("a", "b", 1, invalid))
End Function

Function testCase_Functions_functionsExplicitParams_wrongTypeString()
  ' THIS CRASHES BRIGHTSCRIPT IF CALLER PASSES WRONG TYPE
  result = eval("functionsExplicitParams({}, 0, 1, invalid)")
  return m.AssertEqual(result, &h18)  ' Type Mismatch error
End Function

Function testCase_Functions_functionsExplicitParams_wrongTypeInteger()
  ' THIS CRASHES BRIGHTSCRIPT IF CALLER PASSES WRONG TYPE
  result = eval("functionsExplicitParams({}, ""b"", ""c"", invalid)")
  return m.AssertEqual(result, &h18)  ' Type Mismatch error
End Function

Function testCase_Functions_functionsExplicitParams_wrongTypeDynamic()
  return m.AssertFalse(functionsExplicitParams({}, "b", 1, []))
End Function


''''''''''''''''''''''''''
' functionsDynamicParams
''''''''''''''''''''''''''
Function testCase_Functions_functionsDynamicParams()
  return m.AssertTrue(functionsDynamicParams({}, "b", 1, invalid))
End Function

Function testCase_Functions_functionsDynamicParams_wrongTypeObject()
  return m.AssertFalse(functionsDynamicParams("a", "b", 1, invalid))
End Function

Function testCase_Functions_functionsDynamicParams_wrongTypeString()
  return m.AssertFalse(functionsDynamicParams({}, 0, 1, invalid))
End Function

Function testCase_Functions_functionsDynamicParams_wrongTypeInteger()
  return m.AssertFalse(functionsDynamicParams({}, "b", "c", invalid))
End Function

Function testCase_Functions_functionsDynamicParams_wrongTypeDynamic()
  return m.AssertFalse(functionsDynamicParams({}, "b", 1, []))
End Function




''''''''''''''''''''''''''
' functionsDynamicParams
''''''''''''''''''''''''''
Function testCase_Functions_functionsBareParams()
  return m.AssertTrue(functionsBareParams({}, "b", 1, invalid))
End Function

Function testCase_Functions_functionsBareParams_wrongTypeObject()
  return m.AssertFalse(functionsBareParams("a", "b", 1, invalid))
End Function

Function testCase_Functions_functionsBareParams_wrongTypeString()
  return m.AssertFalse(functionsBareParams({}, 0, 1, invalid))
End Function

Function testCase_Functions_functionsBareParams_wrongTypeInteger()
  return m.AssertFalse(functionsBareParams({}, "b", "c", invalid))
End Function

Function testCase_Functions_functionsBareParams_wrongTypeDynamic()
  return m.AssertFalse(functionsDynamicParams({}, "b", 1, []))
End Function
