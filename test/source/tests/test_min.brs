Function testSuite_min()
  this = BaseTestSuite()
  this.Name = "MinTestSuite"
  this.SetUp = minTestSuite_setUp
  this.addTest("min_int", testCase_min_int)
  this.addTest("min_roInt", testCase_min_roint)
  this.addTest("min_float", testCase_min_float)
  this.addTest("min_invalid", testCase_min_invalid)
  return this
End Function

Function minTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_min_int()
  result = m.AssertTrue(m._.min(1,2) = 1) 
  result = result + m.AssertTrue(m._.min(2,1) = 1)
  return result
End Function

Function testCase_min_roint()
  result = m.AssertTrue(m._.min(Box(1),Box(2)) = 1)
  result = result + m.AssertTrue(m._.min(Box(2),Box(1)) = 1)
  return result
End Function

Function testCase_min_float()
  result = m.AssertTrue(m._.min(1.1,2.1) = 1.1)
  result = result + m.AssertTrue(m._.min(2.1,1.1) = 1.1)
  result = result + m.AssertTrue(m._.min(1,2.1) = 1)
  result = result + m.AssertTrue(m._.min(2.1,1) = 1)
  return result
End Function

Function testCase_min_invalid()
  return m.AssertInvalid(m._.min(invalid, 2))
End Function