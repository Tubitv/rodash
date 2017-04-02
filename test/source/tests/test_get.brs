Function testSuite_get()
  this = BaseTestSuite()
  this.SetUp = getTestSuite_setUp
  this.Name = "GetTestSuite"
  this.addTest("get_simpleString", testCase_get_simpleString)
  this.addTest("get_simpleArray", testCase_get_simpleArray)
  this.addTest("get_deepString", testCase_get_deepString)
  this.addTest("get_deepArray", testCase_get_deepArray)
  this.addTest("get_deepList", testCase_get_deepList)
  this.addTest("get_deepStringInvalid", testCase_get_deepStringInvalid)
  this.addTest("get_deepArrayInvalid", testCase_get_deepArrayInvalid)
  this.addTest("get_default", testCase_get_default)
  this.addTest("get_badAA", testCase_get_badAA)
  this.addTest("get_badAADefault", testCase_get_badAADefault)
  this.addTest("get_badPath", testCase_get_badPath)
  this.addTest("get_badPathDefault", testCase_get_badPathDefault)
  return this
End Function

Function getTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_get_simpleString() As String
  value = m._.get({ a: 1}, "a")
  return m.AssertTrue(value = 1)
End Function

Function testCase_get_simpleArray() As String
  value = m._.get({ a: 1}, ["a"])
  return m.AssertTrue(value = 1)
End Function

Function testCase_get_deepString() As String
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
  value = m._.get(data, "b.d.f")
  return m.AssertTrue(value = 4)
End Function

Function testCase_get_deepArray() As String
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
  value = m._.get(data, ["b","d","f"])
  return m.AssertTrue(value = 4)
End Function

Function testCase_get_deepList() As String
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
  value = m._.get(data, list)
  return m.AssertTrue(value = 4)
End Function

Function testCase_get_deepStringInvalid() As String
  data = {}
  value = m._.get(data, "b.d.f")
  return m.AssertInvalid(value)
End Function

Function testCase_get_deepArrayInvalid() As String
  data = {}
  value = m._.get(data, ["b","d","f"])
  return m.AssertInvalid(value)
End Function

Function testCase_get_default() As String
  value = m._.get({ a: 1}, "a.b.c.d", "default")
  return m.AssertEqual(value, "default")
End Function

Function testCase_get_badAA()
  return m.AssertInvalid(m._.get(invalid, "a.b.c.d"))
End Function

Function testCase_get_badAADefault()
  return m.AssertEqual(m._.get(invalid, "a.b.c.d", "default"), "default")
End Function

Function testCase_get_badPath()
  return m.AssertInvalid(m._.get({ a: 1}, invalid))
End Function

Function testCase_get_badPathDefault()
  return m.AssertEqual(m._.get({a:1}, invalid, "default"), "default")
End Function
