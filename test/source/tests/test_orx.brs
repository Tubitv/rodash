Function testSuite_orx()
  this = BaseTestSuite()
  this.Name = "OrxTestSuite"
  this.SetUp = orxTestSuite_setUp
  this.addTest("orx_variables_true", testCase_orx_variables_true)
  this.addTest("orx_variables_false", testCase_orx_variables_false)
  this.addTest("orx_expressions", testCase_orx_expressions)
  this.addTest("orx_withNativeAnd", testCase_orx_withNativeAnd)
  this.addTest("orx_withNativeOr", testCase_orx_withNativeOr)
  return this
End Function

Function orxTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_orx_variables_true()
  a = true
  b = false
  test = false
  if m._.orx([
    a
    b
    ]) then
    test = true
  end if
  return m.AssertEqual(test, true)
End Function

Function testCase_orx_variables_false()
  a = false
  b = false
  test = false
  if m._.orx([
    a
    b
    ]) then
    test = true
  end if
  return m.AssertEqual(test, false)
End Function

Function testCase_orx_expressions()
  a = true
  b = true
  test = false
  if m._.orx([
    a = true
    b = false
    ]) then
    test = true
  end if
  return m.AssertEqual(test, true)
End Function

Function testCase_orx_withNativeAnd()
  test = false
  if m._.orx([
    true
    ]) and true
    test = true
  end if
  return m.AssertEqual(test, true)
End Function

Function testCase_orx_withNativeOr()
  test = false
  if m._.orx([
    false
    ]) or true
    test = true
  end if
  return m.AssertEqual(test, true)
End Function