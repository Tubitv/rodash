Function testSuite_clone()
  this = BaseTestSuite()
  this.Name = "CloneTestSuite"
  this.SetUp = cloneTestSuite_setUp
  this.addTest("clone_node", testCase_clone_node)
  this.addTest("clone_aa", testCase_clone_aa)
  return this
End Function

Function cloneTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_clone_node()
  source = { a: 1, b: invalid, c: "3" }
  dest = m._.clone(source)
  result = m.AssertNotInvalid(dest)
  skeys = source.keys()
  dkeys = dest.keys()
  result = result + m.AssertEqual(skeys.count(), dkeys.count())
  for i=0 to skeys.count()-1
    result = result + m.AssertEqual(skeys[i], dkeys[i])
    result = result + m.AssertEqual(source[skeys[i]], dest[dkeys[i]])
  end for
  return result
End Function

Function testCase_clone_aa()
  source = CreateObject("roSGNode", "Node")
  dest = m._.clone(source)
  result = m.AssertNotInvalid(dest)
  skeys = source.keys()
  dkeys = dest.keys()
  result = result + m.AssertEqual(skeys.count(), dkeys.count())
  for i=0 to skeys.count()-1
    result = result + m.AssertEqual(skeys[i], dkeys[i])
    result = result + m.AssertEqual(source[skeys[i]], dest[dkeys[i]])
  end for
  return result
End Function
