Function testSuite_intersection()
  this = BaseTestSuite()
  this.Name = "IntersectionTestSuite"
  this.addTest("intersection", testCase_intersection)
  return this
End Function

Function testCase_intersection() As String
  testCases = [
  ' [ <a>,  <b>,  <result>]
    [[1,2], [1,2], [1,2]]        ' a & b
    [[1,2], [1], [1]]     ' a & !b
    [[1], [1,2], [1]]      ' !a & b
    [[1], [2], []]        ' !a & !b
    [[1], ["1"], []]

  ' deep types
  ]
  _ = rodash()
  result = ""
  for each t in testCases
    intersection = _.intersection(t[0], t[1])
    result = result + m.AssertTrue(intersection.count() = t[2].count())
    for i=0 to intersection.count()-1
      result = result + m.AssertEqual(intersection[i], t[2][i])
    end for
  end for
  return result
End Function
