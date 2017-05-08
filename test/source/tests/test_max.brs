Function testSuite_max()
  this = BaseTestSuite()
  this.Name = "MaxTestSuite"
  this.SetUp = maxTestSuite_setUp
  this.addTest("max_int", testCase_max_int)
  this.addTest("max_roInt", testCase_max_roint)
  this.addTest("max_float", testCase_max_float)
  this.addTest("max_invalid", testCase_max_invalid)
  return this
End Function

Function maxTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_max_int()
  result = m.AssertTrue(m._.max(1,2) = 2) 
  result = result + m.AssertTrue(m._.max(2,1) = 2)
  return result
End Function

Function testCase_max_roint()
  result = m.AssertTrue(m._.max(Box(1),Box(2)) = 2)
  result = result + m.AssertTrue(m._.max(Box(2),Box(1)) = 2)
  return result
End Function

Function testCase_max_float()
  result = m.AssertTrue(m._.max(1.1,2.1) = 2.1)
  result = result + m.AssertTrue(m._.max(2.1,1.1) = 2.1)
  result = result + m.AssertTrue(m._.max(1,2.1) = 2.1)
  result = result + m.AssertTrue(m._.max(2.1,1) = 2.1)
  return result
End Function

Function testCase_max_invalid()
  return m.AssertInvalid(m._.max(invalid, 2))
End Function