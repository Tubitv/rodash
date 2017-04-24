Function testSuite_clone()
  this = BaseTestSuite()
  this.Name = "CloneTestSuite"
  this.SetUp = cloneTestSuite_setUp
  this.addTest("clone_node", testCase_clone_node)
  this.addTest("clone_assocarray_roAssociativeArray", testCase_clone_assocarray_roAssociativeArray)
  this.addTest("clone_arrayish_roArray", testCase_clone_arrayish_roArray)
  this.addTest("clone_arrayish_roByteArray", testCase_clone_arrayish_roByteArray)
  this.addTest("clone_arrayish_roList", testCase_clone_arrayish_roList)
  this.addTest("clone_arrayish_roXMLList", testCase_clone_arrayish_roXMLList)
  this.addTest("clone_stringish_string", testCase_clone_stringish_string) 
  this.addTest("clone_stringish_roString", testCase_clone_stringish_roString) 
  return this
End Function

Function cloneTestSuite_setUp()
  m._ = rodash()
  m.arrayishCompareHelper = testCaseHelper_clone_arrayish_compare
End Function

Function testCase_clone_node()
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

Function testCase_clone_assocarray_roAssociativeArray()
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
  ' be sure they don't point to the same object
  source.d = 4
  result = result + m.AssertInvalid(dest.d)
  return result
End Function

''''''''''''''
' arrayish
''''''''''''''

Function testCaseHelper_clone_arrayish_compare(source, dest)
  result = m.AssertNotInvalid(dest)
  result = result + m.AssertEqual(source.count(), dest.count())
  for i=0 to source.count()-1
    result = result + m.AssertTrue(source[i] = dest[i])
  end for
  return result
End Function

Function testCase_clone_arrayish_roArray()
  source = [1, 2, 3, "a", "b", "c"]
  dest = m._.clone(source)
  result = m.arrayishCompareHelper(source, dest)
  ' be sure they don't point to the same object
  source.push("d")
  result = result + m.AssertNotInvalid(source[6])
  result = result + m.AssertInvalid(dest[6])
  return result
End Function

Function testCase_clone_arrayish_roByteArray()
  source = CreateObject("roByteArray")
  source.fromAsciiString("abc")
  dest = m._.clone(source)
  result = m.arrayishCompareHelper(source, dest)
  source.push(77)
  result = result + m.AssertNotInvalid(source[3])
  result = result + m.AssertInvalid(dest[3])
  return result
End Function

Function testCase_clone_arrayish_roList()
  source = CreateObject("roList")
  source.addTail(1)
  source.addTail(2)
  source.addTail(3)
  source.addTail("a")
  source.addTail("b")
  source.addTail("c")
  dest = m._.clone(source)
  result = m.arrayishCompareHelper(source, dest)
  source.addTail("d")
  result = result + m.AssertNotInvalid(source[6])
  result = result + m.AssertInvalid(dest[6])
  return result
End Function

Function testCase_clone_arrayish_roXMLList()
  xml = CreateObject("roXMLElement")
  xml.parse("<element><child>Child 1</child><child>Child 2</child></element>")
  source = xml.getChildElements()
  dest = m._.clone(source)
  result = m.AssertNotInvalid(dest)
  result = result + m.AssertEqual(source.count(), dest.count())
  for i=0 to source.count()-1
    result = result + m.AssertEqual(source[i].genXml(false), dest[i].genXml(false))
  end for
  source.clear()
  result = result + m.AssertTrue(source.count() = 0)
  result = result + m.AssertTrue(dest.count() > 0)
  return result
End Function

''''''''''''''
' stringish
''''''''''''''

Function testCase_clone_stringish_string()
  source = "abcd"
  dest = m._.clone(source)
  result = m.AssertTrue(source = dest)
  source = "wxyz"
  result = result + m.AssertTrue(source <> dest)
  return result
End Function

Function testCase_clone_stringish_roString()
  source = CreateObject("roString")
  source.setString("abcd")
  dest = m._.clone(source)
  print "source = "; source
  print "dest = "; dest
  result = m.AssertTrue(source = dest)
  source.setString("wxyz")
  print "source = "; source
  print "dest = "; dest
  result = result + m.AssertTrue(source <> dest)
  return result
End Function