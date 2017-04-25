Function testSuite_Request()
  this = BaseTestSuite()
  this.Name = "RequestModuleTestSuite"
  this.SetUp = requestTestSuite_setUp
  this.addTest("createRequest", testCase_Request_createRequest)
  this.addTest("createRequest_withMethod", testCase_Request_createRequest_withMethod)
  this.addTest("createRequest_withHeaders", testCase_Request_createRequest_withHeaders)
  this.addTest("createRequest_withBody", testCase_Request_createRequest_withBody)
  this.addTest("createRequest_https", testCase_Request_createRequest_https)
  this.addTest("start_asynchronousWithPort", testCase_Request_start_asynchronousWithPort)
  this.addTest("start_asynchronousWithoutPort", testCase_Request_start_asynchronousWithoutPort)
  this.addTest("start_synchronous", testCase_Request_start_synchronous)
  this.addTest("cancel", testCase_Request_cancel)
  this.addTest("handleEvent", testCase_Request_handleEvent)
  this.addTest("handleEvent_withError", testCase_Request_handleEvent_withError)
  return this
End Function

Function requestTestSuite_setUp()
  m._ = rodash()
End Function


''''''''''''''
' createRequest()
''''''''''''''
Function testCase_Request_createRequest()
  r = m._.createRequest("http://www.google.com")  
  return m.AssertNotInvalid(r)
End Function

Function testCase_Request_createRequest_withMethod()
  result = ""
  validMethods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
  for each method in validMethods
    r = m._.createRequest("http://www.google.com", { method: method })
    result = result + m.AssertNotInvalid(r)
    result = result + m.AssertEqual(r.method, method)
  end for
  return result
End Function

Function testCase_Request_createRequest_withHeaders()
  headers = {
    "Content-type": "application/json"  
  }
  r = m._.createRequest("http://www.google.com", { headers: headers })
  result = ""
  result = result + m.AssertNotInvalid(r)
  result = result + m.AssertAAHasKey(r.headers, "Content-type")
  return result
End Function

Function testCase_Request_createRequest_withBody()
  body = "value=true"
  r = m._.createRequest("http://www.google.com", { body: body })
  result = ""
  result = result + m.AssertNotInvalid(r)
  result = result + m.AssertEqual(r.body, "value=true")
  return result
End Function

Function testCase_Request_createRequest_https()
  r = m._.createRequest("https://www.google.com")
  result = ""
  result = result + m.AssertNotInvalid(r)
  result = result + m.AssertTrue(r.https)
  return result
End Function


''''''''''''''
' start()
''''''''''''''
Function testCase_Request_start_asynchronousWithPort()
  r = m._.createRequest("http://www.google.com")
  port = CreateObject("roMessagePort")
  r.start(false, port)
  message = wait(3000, port)
  result = ""
  result = result + m.AssertNotInvalid(message)
  result = result + m.AssertEqual(type(message), "roUrlEvent")
  return result
End Function

Function testCase_Request_start_asynchronousWithoutPort()
  r = m._.createRequest("http://www.google.com")
  port = r.start()
  message = wait(3000, port)
  result = ""
  result = result + m.AssertNotInvalid(message)
  result = result + m.AssertEqual(type(message), "roUrlEvent")
  return result
End Function

Function testCase_Request_start_synchronous()
  r = m._.createRequest("http://www.google.com")
  response = r.start(true)
  return m.AssertNotEmpty(response)
End Function


''''''''''''''
' cancel()
''''''''''''''
Function testCase_Request_cancel()
  r = m._.createRequest("http://www.google.com")
  r.start()
  r.cancel()
  return m.AssertInvalid(r.urlTransfer)
End Function


''''''''''''''
' handleEvent()
''''''''''''''
Function testCase_Request_handleEvent()
  r = m._.createRequest("http://www.google.com")
  port = r.start()
  message = wait(3000, port)
  result = r.handleEvent(message)
  return m.AssertNotEmpty(result)
End Function

Function testCase_Request_handleEvent_withError()
  r = m._.createRequest("http://www.google.com", { method: "POST" })
  port = r.start()
  message = wait(3000, port)
  resultBody = r.handleEvent(message)
  result = m.AssertNotInvalid(r.urlEvent)
  result = result + m.AssertEqual(r.urlEvent.GetResponseCode(), 405)
  return result
End Function