Function testSuite_max()
  this = BaseTestSuite()
  this.Name = "MaxTestSuite"
  this.SetUp = maxTestSuite_setUp
  this.addTest("max_int", testCase_max_int)
  this.addTest("max_roInt", testCase_max_roint)
  this.addTest("max_float", testCase_max_float)
  this.addTest("max_alltypes", testCase_max_alltypes)
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

Function testCase_max_alltypes()
  types = allTypes()

  result = ""
  for i=0 to types.count()-1
    for j=0 to types.count()-1
      highest = m._.max(types[i][1], types[j][1])
    end for
  end for
  return result
End Function
