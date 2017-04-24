Function testSuite_equal()
  this = BaseTestSuite()
  this.Name = "EqualTestSuite"
  this.SetUp = equalTestSuite_setUp
  this.addTest("equal", testCase_equal)
  return this
End Function

Function equalTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_equal()
  types = [
    [ "invalid",     invalid ]
    [ "boolean",     true ]
    [ "integer",     42% ]
    [ "longInteger", 2349823492& ]
    [ "float",       243.573! ]
    [ "double",      1.23456789D-12# ]
    [ "string",      "hi" ]
    [ "array",       [1,2,3] ]
    [ "assocarray",  {a: 1} ]
    [ "node",        CreateObject("roSGNode", "Node")]
    [ "function",    rodash ]
  ]

  r = ""
  for i=0 to types.count()-1
    for j=0 to types.count()-1
      result = m._.equal(types[i][1], types[j][1])
      if i = j and types[i][0] <> "array" and types[i][0] <> "assocarray" and types[i][0] <> "node"
        r = r + m.AssertTrue(result)
      else if types[i][0] = "boolean" and (types[j][0] = "integer" or types[j][0] = "longInteger" or types[j][0] = "float")
        r = r + m.AssertTrue(result)
      else if types[j][0] = "boolean" and (types[i][0] = "integer" or types[i][0] = "longInteger" or types[i][0] = "float")
        r = r + m.AssertTrue(result)
      else
        r = r + m.AssertFalse(result)
      end if
    end for
  end for
  return r
End Function