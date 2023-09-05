Function testSuite_get()
  this = BaseTestSuite()
  this.SetUp = getTestSuite_setUp
  this.Name = "GetTestSuite"
  this.addTest("get_simpleString", testCase_get_simpleString)
  this.addTest("get_simpleArray", testCase_get_simpleArray)
  this.addTest("get_deepString", testCase_get_deepString)
  this.addTest("get_deepArray", testCase_get_deepArray)
  this.addTest("get_deepList", testCase_get_deepList)
  this.addTest("get_arrayIndex", testCase_get_arrayIndex)
  this.addTest("get_deepArrayIndex", testCase_get_deepArrayIndex)
  this.addTest("get_deepStringInvalid", testCase_get_deepStringInvalid)
  this.addTest("get_deepArrayInvalid", testCase_get_deepArrayInvalid)
  this.addTest("get_default", testCase_get_default)
  this.addTest("get_badAA", testCase_get_badAA)
  this.addTest("get_badAADefault", testCase_get_badAADefault)
  this.addTest("get_badPath", testCase_get_badPath)
  this.addTest("get_badPathDefault", testCase_get_badPathDefault)
  this.addTest("get_simpleField", testCase_get_simpleField)
  this.addTest("get_ChildNode", testCase_get_ChildNode)
  this.addTest("get_defaultForNode", testCase_get_defaultForNode)
  this.addTest("get_badNode", testCase_get_badNode)
  this.addTest("get_badNodeDefault", testCase_get_badNodeDefault)
  this.addTest("get_childInvalid", testCase_get_childInvalid)
  this.addTest("get_deepChildInvalid", testCase_get_deepChildInvalid)
  this.addTest("get_deepChildFromNode", testCase_get_deepChildFromNode)
  this.addTest("get_arrayFieldFromNode", testCase_get_arrayFieldFromNode)
  this.addTest("get_AAFieldFromNode", testCase_get_AAFieldFromNode)
  this.addTest("get_arrayFieldFromDeepChildNode", testCase_get_arrayFieldFromDeepChildNode)
  this.addTest("get_AAFieldFromDeepChildNode", testCase_get_AAFieldFromDeepChildNode)
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


Function testCase_get_arrayIndex() As String
  value = m._.get(["a", "b"], "0")
  return m.AssertTrue(value = "a")
End Function

Function testCase_get_deepArrayIndex() As String
  data = {
    a: 1
    b: [
      {
        c: 2,
        d: [3, 4]
      }
    ]
  }
  value = m._.get(data, "b[0].d[0]")
  return m.AssertTrue(value = 3)
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

Function testCase_get_simpleField()
  source = CreateObject("roSGNode", "ContentNode")
  source.id = "parentNode"
  child1 = source.createChild("ContentNode")
  child1.id = "abc"

  value = m._.get(source, "id")
  return m.AssertTrue(value = "parentNode")
End Function

Function testCase_get_ChildNode()
  source = CreateObject("roSGNode", "ContentNode")
  source.id = "parentNode"
  child1 = source.createChild("ContentNode")
  child1.id = "abc"

  value = m._.get(source, "0.id")
  return m.AssertTrue(value = "abc")
End Function

Function testCase_get_defaultForNode()
  source = CreateObject("roSGNode", "ContentNode")
  source.id = "parentNode"
  child1 = source.createChild("ContentNode")
  child1.id = "abc"

  value = m._.get(source, "0.0.id", "def")
  return m.AssertEqual(value, "def")
End Function

Function testCase_get_badNode()
  return m.AssertInvalid(m._.get(invalid, "id"))
End Function

Function testCase_get_badNodeDefault()
  return m.AssertEqual(m._.get(invalid, "id", "default"), "default")
End Function

Function testCase_get_childInvalid()
  source = CreateObject("roSGNode", "ContentNode")
  source.id = "parentNode"

  value = m._.get(source, "0.id")
  return m.AssertInvalid(value)
End Function

Function testCase_get_deepChildInvalid()
  source = CreateObject("roSGNode", "ContentNode")
  source.id = "parentNode"
  child1 = source.createChild("ContentNode")
  child1.id = "abc"
  child2 = source.createChild("ContentNode")
  child2.id = "def"
  grandchild1 = child2.createChild("ContentNode")
  grandchild1.id = "ghi"

  value = m._.get(source, "0.3.id")
  return m.AssertInvalid(value)
End function

Function testCase_get_deepChildFromNode()
  source = CreateObject("roSGNode", "ContentNode")
  source.id = "parentNode"
  child1 = source.createChild("ContentNode")
  child1.id = "abc"
  child2 = source.createChild("ContentNode")
  child2.id = "def"
  grandchild1 = child2.createChild("ContentNode")
  grandchild1.id = "ghi"
  grandchild2 = child2.createChild("ContentNode")
  grandchild2.id = "jkl"

  value = m._.get(source, "1.1.id")
  return m.AssertInvalid(value)
End Function

Function testCase_get_arrayFieldFromNode()
  source = CreateObject("roSGNode", "ContentNode")
  source.id = "parentNode"
  source.abcArray = ["a","b","c"]

  value = m._.get(source, "abcArray[0]")
  return m.AssertEqual(value, "a")
End Function

Function testCase_get_AAFieldFromNode()
  source = CreateObject("roSGNode", "ContentNode")
  source.id = "parentNode"
  source.abcAA = {a: 1, b: 2, c: 3}

  value = m._.get(source, "abcAA.b")
  return m.AssertEqual(value, 2)
End Function

Function testCase_get_arrayFieldFromDeepChildNode()
  source = CreateObject("roSGNode", "ContentNode")
  source.id = "parentNode"
  child1 = source.createChild("ContentNode")
  child1.id = "abc"
  child2 = source.createChild("ContentNode")
  child2.id = "def"
  grandchild1 = child2.createChild("ContentNode")
  grandchild1.id = "ghi"
  grandchild1.abcArray = ["a","b","c"]

  value = m._.get(source, "1.0.abcArray[0]")
  return m.AssertEqual(value, "a")
End Function

Function testCase_get_AAFieldFromDeepChildNode()
  source = CreateObject("roSGNode", "ContentNode")
  source.id = "parentNode"
  child1 = source.createChild("ContentNode")
  child1.id = "abc"
  child2 = source.createChild("ContentNode")
  child2.id = "def"
  grandchild1 = child2.createChild("ContentNode")
  grandchild1.id = "ghi"
  grandchild1.abcAA = {a: 1, b: 2, c: 3}

  value = m._.get(source, "1.0.abcAA.a")
  return m.AssertEqual(value, 1)
End Function
