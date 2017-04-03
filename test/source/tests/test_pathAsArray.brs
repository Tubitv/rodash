Function testSuite_pathAsArray()
  this = BaseTestSuite()
  this.Name = "PathAsArrayTestSuite"
  this.SetUp = pathAsArrayTestSuite_setUp

  ' String-formatted path (the arg type, not the path string contents)
  this.addTest("pathAsArray_string_singleString", testCase_pathAsArray_string_singleString)
  this.addTest("pathAsArray_string_singleStringLeadingDot", testCase_pathAsArray_string_singleStringLeadingDot)
  this.addTest("pathAsArray_string_multipleString", testCase_pathAsArray_string_multipleString)
  this.addTest("pathAsArray_string_singleArray", testCase_pathAsArray_string_singleArray)
  this.addTest("pathAsArray_string_multipleArray", testCase_pathAsArray_string_multipleArray)
  this.addTest("pathAsArray_string_mixed", testCase_pathAsArray_string_mixed)

  ' Array-formatted path
  this.addTest("pathAsArray_array_simpleString", testCase_pathAsArray_array_simpleString)
  this.addTest("pathAsArray_array_multipleString", testCase_pathAsArray_array_multipleString)
  this.addTest("pathAsArray_array_singleArray", testCase_pathAsArray_array_singleArray)
  this.addTest("pathAsArray_array_multipleArray", testCase_pathAsArray_array_multipleArray)
  this.addTest("pathAsArray_array_mixed", testCase_pathAsArray_array_mixed)
  this.addTest("pathAsArray_array_mixed_leadingDot", testCase_pathAsArray_array_mixedLeadingDot)

  this.addTest("pathAsArray_torture", testCase_pathAsArray_torture)

  ' negative tests
  return this
End Function

Function pathAsArrayTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_pathAsArray_string_singleString()
  out = m._.pathAsArray_("a")
  r = m.AssertTrue(out.count() = 1)
  r = r + m.AssertTrue(out[0] = "a")
  return r
End Function

Function testCase_pathAsArray_string_singleStringLeadingDot()
  out = m._.pathAsArray_(".a")
  r = m.AssertTrue(out.count() = 1)
  r = r + m.AssertTrue(out[0] = "a")
  return r
End Function

Function testCase_pathAsArray_string_multipleString()
  out = m._.pathAsArray_("a.b.c")
  r = m.AssertTrue(out.count() = 3)
  r = r + m.AssertTrue(out[0] = "a")
  r = r + m.AssertTrue(out[1] = "b")
  r = r + m.AssertTrue(out[2] = "c")
  return r
End Function

Function testCase_pathAsArray_string_singleArray()
  out = m._.pathAsArray_("[0]")
  r = m.AssertTrue(out.count() = 1)
  r = r + m.AssertTrue(out[0] = 0)
  return r
End Function

Function testCase_pathAsArray_string_multipleArray()
  out = m._.pathAsArray_("[0][1][2]")
  r = m.AssertTrue(out.count() = 3)
  r = r + m.AssertTrue(out[0] = 0)
  r = r + m.AssertTrue(out[1] = 1)
  r = r + m.AssertTrue(out[2] = 2)
  return r
End Function

Function testCase_pathAsArray_string_mixed()
  out = m._.pathAsArray_("a[0].b[1].c[2]")
  r = m.AssertTrue(out.count() = 6)
  r = r + m.AssertTrue(out[0] = "a")
  r = r + m.AssertTrue(out[1] = 0)
  r = r + m.AssertTrue(out[2] = "b")
  r = r + m.AssertTrue(out[3] = 1)
  r = r + m.AssertTrue(out[4] = "c")
  r = r + m.AssertTrue(out[5] = 2)
  return r
End Function

Function testCase_pathAsArray_array_simpleString()
  out = m._.pathAsArray_(["a"])
  r = m.AssertTrue(out.count() = 1)
  r = r + m.AssertTrue(out[0] = "a")
  return r
End Function

Function testCase_pathAsArray_array_multipleString()
  out = m._.pathAsArray_(["a","b","c"])
  r = m.AssertTrue(out.count() = 3)
  r = r + m.AssertTrue(out[0] = "a")
  r = r + m.AssertTrue(out[1] = "b")
  r = r + m.AssertTrue(out[2] = "c")
  return r
End Function

Function testCase_pathAsArray_array_singleArray()
  out = m._.pathAsArray_(["[0]"])
  r = m.AssertTrue(out.count() = 1)
  r = r + m.AssertTrue(out[0] = 0)
  return r
End Function

Function testCase_pathAsArray_array_multipleArray()
  out = m._.pathAsArray_(["[0]","[1]","[2]"])
  r = m.AssertTrue(out.count() = 3)
  r = r + m.AssertTrue(out[0] = 0)
  r = r + m.AssertTrue(out[1] = 1)
  r = r + m.AssertTrue(out[2] = 2)
  return r
End Function

Function testCase_pathAsArray_array_mixed()
  out = m._.pathAsArray_(["a[0]","b[1]","c[2]"])
  r = m.AssertTrue(out.count() = 6)
  r = r + m.AssertTrue(out[0] = "a")
  r = r + m.AssertTrue(out[1] = 0)
  r = r + m.AssertTrue(out[2] = "b")
  r = r + m.AssertTrue(out[3] = 1)
  r = r + m.AssertTrue(out[4] = "c")
  r = r + m.AssertTrue(out[5] = 2)
  return r
End Function

Function testCase_pathAsArray_array_mixedLeadingDot()
  out = m._.pathAsArray_([".a[0]",".b[1]",".c[2]"])
  r = m.AssertTrue(out.count() = 6)
  r = r + m.AssertTrue(out[0] = "a")
  r = r + m.AssertTrue(out[1] = 0)
  r = r + m.AssertTrue(out[2] = "b")
  r = r + m.AssertTrue(out[3] = 1)
  r = r + m.AssertTrue(out[4] = "c")
  r = r + m.AssertTrue(out[5] = 2)
  return r
End Function

' Specifically addresses:
'    - identifiers starting with '_'
'    - identifiers with mixed alpha, num, and '_'
'    - identifiers in caps
'    - sequential alpha identifiers
'    - sequential array indices
'    - leading dot
Function testCase_pathAsArray_torture()
  subject = [".a[0].b._c.f_g_h._.j_5_k.f48s[1][2][3].b.ABC[4]", "[0].y"]
  out = m._.pathAsArray_(subject)
  r = m.AssertTrue(out.count() = 16)
  r = r + m.AssertTrue(out[0] = "a")
  r = r + m.AssertTrue(out[1] = 0)
  r = r + m.AssertTrue(out[2] = "b")
  r = r + m.AssertTrue(out[3] = "_c")
  r = r + m.AssertTrue(out[4] = "f_g_h")
  r = r + m.AssertTrue(out[5] = "_")
  r = r + m.AssertTrue(out[6] = "j_5_k")
  r = r + m.AssertTrue(out[7] = "f48s")
  r = r + m.AssertTrue(out[8] = 1)
  r = r + m.AssertTrue(out[9] = 2)
  r = r + m.AssertTrue(out[10] = 3)
  r = r + m.AssertTrue(out[11] = "b")
  r = r + m.AssertTrue(out[12] = "ABC")
  r = r + m.AssertTrue(out[13] = 4)
  r = r + m.AssertTrue(out[14] = 0)
  r = r + m.AssertTrue(out[15] = "y")
  return r
End Function
