Function testSuite_min()
  this = BaseTestSuite()
  this.Name = "MinTestSuite"
  this.SetUp = minTestSuite_setUp
  this.addTest("min_int", testCase_min_int)
  this.addTest("min_roInt", testCase_min_roint)
  this.addTest("min_float", testCase_min_float)
  this.addTest("min_invalid", testCase_min_invalid)
  this.addTest("min_alltypes", testCase_min_alltypes)
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
  result = m.AssertTrue(m._.min(invalid, 2) = 2)
  result += m.AssertTrue(m._.min(3, invalid) = 3)
  result += m.AssertInvalid(m._.min(invalid, invalid))
  return result
End Function

Function testCase_min_alltypes()
  types = allTypes()

  result = ""
  for i=0 to types.count()-1
    for j=0 to types.count()-1
      lowest = m._.min(types[i][1], types[j][1])
    end for
  end for
  return result
End Function
