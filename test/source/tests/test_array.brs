Function testSuite_Array()
  this = BaseTestSuite()

  this.Name = "ArrayTestSuite"
  this.addTest("intersection", testCase_Array_intersection)
  return this
End Function

Function testCase_Array_intersection() As String
  testCases = [
  ' [ <a>,  <b>,  <result>]
    [[1,2], [1,2], [1,2]]        ' a & b
    [[1,2], [1], [1]]     ' a & !b
    [[1], [1,2], [1]]      ' !a & b
    [[1], [2], []]        ' !a & !b
    [[1], ["1"], []]

  ' deep types
  ]
  array = ArrayModule()
  result = ""
  for each t in testCases
    result = result + m.AssertEqual(array.intersection(t[0], t[1]), t[2])
  end for
  return result
End Function
