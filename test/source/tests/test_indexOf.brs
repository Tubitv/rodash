Function testSuite_indexOf()
  this = BaseTestSuite()
  this.Name = "IndexOfTestSuite"
  this.SetUp = indexOfTestSuite_setUp
  this.addTest("indexOf", testCase_indexOf)
  return this
End Function

Function indexOfTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_indexOf()
  index = m._.indexOf([1,2,3], 2)
  return m.AssertTrue(index = 1)
End Function