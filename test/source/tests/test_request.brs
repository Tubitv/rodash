Function testSuite_Request()
  this = BaseTestSuite()

  this.Name = "RequestModuleTestSuite"

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


''''''''''''''
' createRequest()
''''''''''''''
Function testCase_Request_createRequest()
  request = RequestModule()
  r = request.createRequest("http://www.google.com")  
  return m.AssertNotInvalid(r)
End Function

Function testCase_Request_createRequest_withMethod()
  request = RequestModule()
  result = ""
  validMethods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
  for each method in validMethods
    r = request.createRequest("http://www.google.com", { method: method })
    result = result + m.AssertNotInvalid(r)
    result = result + m.AssertEqual(r.method, method)
  end for
  return result
End Function

Function testCase_Request_createRequest_withHeaders()
  request = RequestModule()
  headers = {
    "Content-type": "application/json"  
  }
  r = request.createRequest("http://www.google.com", { headers: headers })
  result = ""
  result = result + m.AssertNotInvalid(r)
  result = result + m.AssertAAHasKey(r.headers, "Content-type")
  return result
End Function

Function testCase_Request_createRequest_withBody()
  request = RequestModule()
  body = "value=true"
  r = request.createRequest("http://www.google.com", { body: body })
  result = ""
  result = result + m.AssertNotInvalid(r)
  result = result + m.AssertEqual(r.body, "value=true")
  return result
End Function

Function testCase_Request_createRequest_https()
  request = RequestModule()
  r = request.createRequest("https://www.google.com")
  result = ""
  result = result + m.AssertNotInvalid(r)
  result = result + m.AssertTrue(r.https)
  return result
End Function


''''''''''''''
' start()
''''''''''''''
Function testCase_Request_start_asynchronousWithPort()
  request = RequestModule()
  r = request.createRequest("http://www.google.com")
  port = CreateObject("roMessagePort")
  r.start(false, port)
  message = wait(3000, port)
  result = ""
  result = result + m.AssertNotInvalid(message)
  result = result + m.AssertEqual(type(message), "roUrlEvent")
  return result
End Function

Function testCase_Request_start_asynchronousWithoutPort()
  request = RequestModule()
  r = request.createRequest("http://www.google.com")
  port = r.start()
  message = wait(3000, port)
  result = ""
  result = result + m.AssertNotInvalid(message)
  result = result + m.AssertEqual(type(message), "roUrlEvent")
  return result
End Function

Function testCase_Request_start_synchronous()
  request = RequestModule()
  r = request.createRequest("http://www.google.com")
  response = r.start(true)
  return m.AssertNotEmpty(response)
End Function


''''''''''''''
' cancel()
''''''''''''''
Function testCase_Request_cancel()
  request = RequestModule()
  r = request.createRequest("http://www.google.com")
  r.start()
  r.cancel()
  return m.AssertInvalid(r.urlTransfer)
End Function


''''''''''''''
' handleEvent()
''''''''''''''
Function testCase_Request_handleEvent()
  request = RequestModule()
  r = request.createRequest("http://www.google.com")
  port = r.start()
  message = wait(3000, port)
  result = r.handleEvent(message)
  return m.AssertNotEmpty(result)
End Function

Function testCase_Request_handleEvent_withError()
  request = RequestModule()
  r = request.createRequest("http://www.google.com", { method: "POST" })
  port = r.start()
  message = wait(3000, port)
  resultBody = r.handleEvent(message)
  result = m.AssertNotInvalid(r.urlEvent)
  result = result + m.AssertEqual(r.urlEvent.GetResponseCode(), 405)
  return result
End Function