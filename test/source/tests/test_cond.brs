Function testSuite_cond()
  this = BaseTestSuite()
  this.Name = "CondTestSuite"
  this.SetUp = condTestSuite_setUp
  this.addTest("cond_true", testCase_cond_true)
  this.addTest("cond_false", testCase_cond_false)
  return this
End Function

Function condTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_cond_true()
  test = m._.cond(1 = 1, true, false)
  return m.AssertEqual(test, true)
End Function

Function testCase_cond_false()
  test = m._.cond(1 = 2, true, false)
  return m.AssertEqual(test, false)
End Function