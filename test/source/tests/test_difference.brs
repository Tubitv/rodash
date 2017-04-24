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
    difference = _.difference(t[0], t[1])
    result = result + m.AssertTrue(difference.count() = t[2].count())
    for i=0 to difference.count()-1
      result = result + m.AssertEqual(difference[i], t[2][i])
    end for
  end for
  '#####
  if result <> "" then print result
  '#####
  return result
End Function
