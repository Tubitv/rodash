' For testing, here is a list of native types with example values
Function allTypes()
  return [
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
End Function
