Function testSuite_difference()
  this = BaseTestSuite()
  this.Name = "DifferenceTestSuite"
  this.addTest("difference", testCase_difference)
  return this
End Function

Function testCase_difference() As String
  testCases = [
  ' [ <a>,  <b>,  <result>]
    [[1,2], [1,2], []]        ' a & b
    [[1,2], [1], [2]]     ' a & !b
    [[1], [1,2], []]      ' !a & b
    [[1], [2], [1]]        ' !a & !b
    [[1], ["1"], [1]]

  ' deep types
  ]
  _ = rodash()
  result = ""
  for each t in testCases
    result = result + m.AssertEqual(_.difference(t[0], t[1]), t[2])
  end for
  return result
End Function
