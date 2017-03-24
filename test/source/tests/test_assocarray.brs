Function testSuite_AssocArray()
  this = BaseTestSuite()

  this.SetUp = assocArrayTestSuite_SetUp

  this.Name = "AssocArrayTestSuite"
  this.addTest("get_simpleString", testCase_AssocArray_get_simpleString)
  this.addTest("get_simpleArray", testCase_AssocArray_get_simpleArray)
  this.addTest("get_deepString", testCase_AssocArray_get_deepString)
  this.addTest("get_deepArray", testCase_AssocArray_get_deepArray)
  this.addTest("get_deepList", testCase_AssocArray_get_deepList)
  this.addTest("get_deepStringInvalid", testCase_AssocArray_get_deepStringInvalid)
  this.addTest("get_deepArrayInvalid", testCase_AssocArray_get_deepArrayInvalid)
  this.addTest("get_default", testCase_AssocArray_get_default)
  this.addTest("get_badAA", testCase_AssocArray_get_badAA)
  this.addTest("get_badAADefault", testCase_AssocArray_get_badAADefault)
  this.addTest("get_badPath", testCase_AssocArray_get_badPath)
  this.addTest("get_badPathDefault", testCase_AssocArray_get_badPathDefault)
  this.addTest("set_simpleString", testCase_AssocArray_set_simpleString)
  this.addTest("set_simpleArray", testCase_AssocArray_set_simpleArray)
  this.addTest("set_deepString", testCase_AssocArray_set_deepString)
  this.addTest("set_deepArray", testCase_AssocArray_set_deepArray)
  this.addTest("set_badAA", testCase_AssocArray_set_badAA)
  this.addTest("set_badPath", testCase_AssocArray_set_badPath)
  this.addTest("set_pathOverwritesPrimitives", testCase_AssocArray_set_pathOverwritesPrimitives)
  return this
End Function

Function assocArrayTestSuite_SetUp()
  m.aa = AssocArrayModule()
End Function


''''''''''''''
' get()
''''''''''''''

Function testCase_AssocArray_get_simpleString() As String
  value = m.aa.get({ a: 1}, "a")
  return m.AssertTrue(value = 1)
End Function

Function testCase_AssocArray_get_simpleArray() As String
  value = m.aa.get({ a: 1}, ["a"])
  return m.AssertTrue(value = 1)
End Function

Function testCase_AssocArray_get_deepString() As String
  data = {
    a: 1
    b: {
      c: 2
      d: {
        e: 3
        f: 4
      }
    }
  }
  value = m.aa.get(data, "b.d.f")
  return m.AssertTrue(value = 4)
End Function

Function testCase_AssocArray_get_deepArray() As String
  data = {
    a: 1
    b: {
      c: 2
      d: {
        e: 3
        f: 4
      }
    }
  }
  value = m.aa.get(data, ["b","d","f"])
  return m.AssertTrue(value = 4)
End Function

Function testCase_AssocArray_get_deepList() As String
  data = {
    a: 1
    b: {
      c: 2
      d: {
        e: 3
        f: 4
      }
    }
  }
  list = CreateObject("roList")
  list.push("b")
  list.push("d")
  list.push("f")
  value = m.aa.get(data, list)
  return m.AssertTrue(value = 4)
End Function

Function testCase_AssocArray_get_deepStringInvalid() As String
  data = {}
  value = m.aa.get(data, "b.d.f")
  return m.AssertInvalid(value)
End Function

Function testCase_AssocArray_get_deepArrayInvalid() As String
  data = {}
  value = m.aa.get(data, ["b","d","f"])
  return m.AssertInvalid(value)
End Function

Function testCase_AssocArray_get_default() As String
  value = m.aa.get({ a: 1}, "a.b.c.d", "default")
  return m.AssertEqual(value, "default")
End Function

Function testCase_AssocArray_get_badAA()
  return m.AssertInvalid(m.aa.get(invalid, "a.b.c.d"))
End Function

Function testCase_AssocArray_get_badAADefault()
  return m.AssertEqual(m.aa.get(invalid, "a.b.c.d", "default"), "default")
End Function

Function testCase_AssocArray_get_badPath()
  return m.AssertInvalid(m.aa.get({ a: 1}, invalid))
End Function

Function testCase_AssocArray_get_badPathDefault()
  return m.AssertEqual(m.aa.get({a:1}, invalid, "default"), "default")
End Function



''''''''''''''
' set()
''''''''''''''

Function testCase_AssocArray_set_simpleString() As String
  result = m.aa.set({ a: 1}, "a", 2)
  return m.AssertTrue(result.a = 2)
End Function

Function testCase_AssocArray_set_simpleArray() As String
  result = m.aa.set({ a: 1}, ["a"], 2)
  return m.AssertTrue(result.a = 2)
End Function

Function testCase_AssocArray_set_deepString() As String
  data = {}
  m.aa.set(data, "b.d.f", 3)
  return m.AssertTrue(data.b.d.f = 3)
End Function

Function testCase_AssocArray_set_deepArray() As String
  data = {}
  m.aa.set(data, ["b","d","f"], 3)
  return m.AssertTrue(data.b.d.f = 3)
End Function

Function testCase_AssocArray_set_badAA() As String
  result = m.aa.set(invalid, ["b","d","f"], 3)
  return m.AssertInvalid(result)
End Function

Function testCase_AssocArray_set_badPath() As String
  data = {}
  result = m.aa.set(data, invalid, 3)
  return m.AssertNotInvalid(result)
End Function

Function testCase_AssocArray_set_pathOverwritesPrimitives() As String
  data = {
    a: 1
    b: 2
  }
  result = m.aa.set(data, ["b","d","f"], 3)
  return m.AssertTrue(data.b.d.f = 3)
End Function
