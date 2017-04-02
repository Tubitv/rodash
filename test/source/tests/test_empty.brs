Function testSuite_Empty()
  this = BaseTestSuite()

  this.Name = "EmptyTestSuite"
  this.SetUp = emptyTestSuite_setUp
  this.addTest("empty_invalid", testCase_empty_invalid)
  this.addTest("empty_stringEmpty", testCase_empty_stringEmpty)
  this.addTest("empty_stringNotEmpty", testCase_empty_stringNotEmpty)
  this.addTest("empty_arrayEmpty", testCase_empty_arrayEmpty)
  this.addTest("empty_arrayNotEmpty", testCase_empty_arrayNotEmpty)
  this.addTest("empty_aaEmpty", testCase_empty_aaEmpty)
  this.addTest("empty_aaNotEmpty", testCase_empty_aaNotEmpty)
  return this
End Function

Function emptyTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_empty_invalid()
  return m.AssertTrue(m._.empty(invalid))
End Function

Function testCase_empty_stringEmpty()
  return m.AssertTrue(m._.empty(""))
End Function

Function testCase_empty_stringNotEmpty()
  return m.AssertFalse(m._.empty("abc"))
End Function

Function testCase_empty_aaEmpty()
  return m.AssertTrue(m._.empty({}))
End Function

Function testCase_empty_aaNotEmpty()
  return m.AssertFalse(m._.empty({a:1}))
End Function

Function testCase_empty_arrayEmpty()
  return m.AssertTrue(m._.empty([]))
End Function

Function testCase_empty_arrayNotEmpty()
  return m.AssertFalse(m._.empty(["a"]))
End Function