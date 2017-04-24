Function testSuite_map()
  this = BaseTestSuite()
  this.Name = "MapTestSuite"
  this.SetUp = mapTestSuite_setUp
  this.addTest("map_array_lambda", testCase_map_array_lambda)
  'this.addTest("map_array_rofunction", testCase_map_array_rofunction_native)
  this.addTest("map_array_rofunction", testCase_map_array_rofunction_nonNative)
  this.addTest("map_list", testCase_map_list)
  this.addTest("map_bytearray", testCase_map_bytearray)
  return this
End Function

Function mapTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_map_array_lambda()
  square = m._.map([1,2,3], Function(x)
    return x*x
  End Function)
  result = m.AssertNotInvalid(square)
  result = result + m.AssertEqual(type(square), "roArray")
  result = result + m.AssertTrue(square[0] = 1)
  result = result + m.AssertTrue(square[1] = 4)
  result = result + m.AssertTrue(square[2] = 9)
  return result
End Function

' NOTE: This fails because native functions don't return a type() of "roFunction" and can't be passed as function arguments.  They are received by the function as <UNINITIALIZED>.
Function testCase_map_array_rofunction_native()
  print "Abs(2) = "; Abs(2)
  print "type(Abs) = "; type(Abs)
  absolute = m._.map([-1,-2,-3], Abs)
  result = m.AssertNotInvalid(absolute)
  result = result + m.AssertEqual(type(absolute), "roArray")
  result = result + m.AssertTrue(absolute[0] = 1)
  result = result + m.AssertTrue(absolute[1] = 4)
  result = result + m.AssertTrue(absolute[2] = 9)
  return result
End Function

Function testCaseHelper_map_sign(x)
  if x = 0
    return 0
  else if x < 0
    return -1
  else
    return 1
  end if
End Function

Function testCase_map_array_rofunction_nonNative()
  sign = m._.map([-4,0,4], testCaseHelper_map_sign)
  result = m.AssertNotInvalid(sign)
  result = result + m.AssertEqual(type(sign), "roArray")
  result = result + m.AssertTrue(sign[0] = -1)
  result = result + m.AssertTrue(sign[1] = 0)
  result = result + m.AssertTrue(sign[2] = 1)
  return result
End Function

Function testCase_map_list()
  list = CreateObject("roList")
  list.push(4)
  list.push(0)
  list.push(-4)
  sign = m._.map(list, testCaseHelper_map_sign)
  result = m.AssertNotInvalid(sign)
  result = result + m.AssertEqual(type(sign), "roArray")
  result = result + m.AssertTrue(sign[0] = 1)
  result = result + m.AssertTrue(sign[1] = 0)
  result = result + m.AssertTrue(sign[2] = -1)
  return result
End Function

Function testCaseHelper_map_toupper(s)
End Function

Function testCase_map_bytearray()
  bytes = CreateObject("roByteArray")
  bytes.fromAsciiString("abc")
  hex = m._.map(bytes, Function(s): return StrI(s, 16):  End Function)
  result = m.AssertNotInvalid(hex)
  result = result + m.AssertEqual(type(hex), "roArray")
  result = result + m.AssertTrue(hex[0] = "61")
  result = result + m.AssertTrue(hex[1] = "62")
  result = result + m.AssertTrue(hex[2] = "63")
  return result
End Function