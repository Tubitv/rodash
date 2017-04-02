Function testSuite_set()
  this = BaseTestSuite()
  this.SetUp = setTestSuite_SetUp
  this.Name = "SetTestSuite"
  this.addTest("set_simpleString", testCase_set_simpleString)
  this.addTest("set_simpleArray", testCase_set_simpleArray)
  this.addTest("set_deepString", testCase_set_deepString)
  this.addTest("set_deepArray", testCase_set_deepArray)
  this.addTest("set_badAA", testCase_set_badAA)
  this.addTest("set_badPath", testCase_set_badPath)
  this.addTest("set_pathOverwritesPrimitives", testCase_set_pathOverwritesPrimitives)
  return this
End Function

Function setTestSuite_SetUp()
  m._ = rodash()
End Function

Function testCase_set_simpleString() As String
  result = m._.set({ a: 1}, "a", 2)
  return m.AssertTrue(result.a = 2)
End Function

Function testCase_set_simpleArray() As String
  result = m._.set({ a: 1}, ["a"], 2)
  return m.AssertTrue(result.a = 2)
End Function

Function testCase_set_deepString() As String
  data = {}
  m._.set(data, "b.d.f", 3)
  return m.AssertTrue(data.b.d.f = 3)
End Function

Function testCase_set_deepArray() As String
  data = {}
  m._.set(data, ["b","d","f"], 3)
  return m.AssertTrue(data.b.d.f = 3)
End Function

Function testCase_set_badAA() As String
  result = m._.set(invalid, ["b","d","f"], 3)
  return m.AssertInvalid(result)
End Function

Function testCase_set_badPath() As String
  data = {}
  result = m._.set(data, invalid, 3)
  return m.AssertNotInvalid(result)
End Function

Function testCase_set_pathOverwritesPrimitives() As String
  data = {
    a: 1
    b: 2
  }
  result = m._.set(data, ["b","d","f"], 3)
  return m.AssertTrue(data.b.d.f = 3)
End Function