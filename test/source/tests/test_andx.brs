Function testSuite_andx()
  this = BaseTestSuite()
  this.Name = "AndxTestSuite"
  this.SetUp = andxTestSuite_setUp
  this.addTest("andx_variables_true", testCase_andx_variables_true)
  this.addTest("andx_variables_false", testCase_andx_variables_false)
  this.addTest("andx_expressions", testCase_andx_expressions)
  this.addTest("andx_withNativeAnd", testCase_andx_withNativeAnd)
  this.addTest("andx_withNativeOr", testCase_andx_withNativeOr)
  return this
End Function

Function andxTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_andx_variables_true()
  a = true
  b = true
  test = false
  if m._.andx([
    a
    b
    ]) then
    test = true
  end if
  return m.AssertEqual(test, true)
End Function

Function testCase_andx_variables_false()
  a = true
  b = false
  test = false
  if m._.andx([
    a
    b
    ]) then
    test = true
  end if
  return m.AssertEqual(test, false)
End Function

Function testCase_andx_expressions()
  a = true
  b = false
  test = false
  if m._.andx([
    a = true
    b = false
    ]) then
    test = true
  end if
  return m.AssertEqual(test, true)
End Function

Function testCase_andx_withNativeAnd()
  test = false
  if m._.andx([
    true
    ]) and true
    test = true
  end if
  return m.AssertEqual(test, true)
End Function

Function testCase_andx_withNativeOr()
  test = false
  if m._.andx([
    false
    ]) or true
    test = true
  end if
  return m.AssertEqual(test, true)
End Function