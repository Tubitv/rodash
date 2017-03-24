Function RequestModule()
  return {
    ' public methods
    createRequest: request_createRequest_
    
    ' private methods
    start_: request_start_
    cancel_: request_cancel_
    handleEvent_: request_handleEvent_
  }
End Function



'***************************
'* Module functions
'***************************

' Create a new request object - inspired by node-fetch
'
' @url       - the full url to be requested
' @options   - request options:
'                 method:        - 'GET', 'PUT', 'POST', 'DELETE', 'PATCH'
'                 headers: {}    - request header. format {a:'1'}
'                 body:          - request body as string

Function request_createRequest_(url As String, options={} As Object) As Object

  ' Check if HTTPS, when we'll have to set certs for the request object
  if Left(LCase(url), 5) = "https" then
    https = true
  else
    https = false
  end if

  ' method validation
  validMethods = {"GET":true, "PUT":true, "POST":true, "DELETE":true, "PATCH":true}
  if options <> invalid and options.method <> invalid and validMethods.DoesExist(UCase(options.method)) then
    method = UCase(options.method)
  else
    method = "GET"
  end if

  ' headers
  if options <> invalid and options.headers <> invalid and type(options.headers) = "roAssociativeArray" then
    headers = options.headers
  else
    headers = {}
  end if

  'body
  if options <> invalid and options.body <> invalid and (type(options.body) = "String" or type(options.body) = "roString") then
    body = options.body
  else
    body = ""
  end if

  return {
    url: url
    https: https
    headers: headers
    body: body
    method: method
    id: CreateObject("roDeviceInfo").GetRandomUUID()
    urlTransfer: invalid
    urlEvent: invalid      ' response roUrlEvent
    
    ' public methods
    start: m.start_
    cancel: m.cancel_
    handleEvent: m.handleEvent_
  }
End Function


' The intention here is to act in one of 2 ways, with an option:
'  1. Run the request asynchronously, with port allocated by this function
'      request = createRequest("http://www.google.com")
'      port = request.start()
'      msg = wait(0, port)
'
'  2. Run the request asynchronously with previously alloated port
'      request = createRequest("http://www.google.com")
'      port = CreateObject("MessagePort")
'      request.start(false, port)
'      msg = wait(0, port)
'
'  3. Run the request synchronously
'      request = createRequest("http://www.google.com")
'      result = request.start(true)
'
'
'TODO: Test that roURLTransfer can do keep-alives across allocations or if we need to reuse roURLTransfer objects
Function request_start_(synchronous=false As Boolean, messagePort=invalid As Object) As Object

  urlTransfer = CreateObject("roUrlTransfer")
  urlTransfer.SetUrl(m.url)
  if m.https then
    urlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
  end if
  urlTransfer.SetRequest(m.method)
  urlTransfer.EnableEncodings(true)
  urlTransfer.RetainBodyOnError(true)
  if messagePort = invalid then
    messagePort = CreateObject("roMessagePort")
  end if
  urlTransfer.SetMessagePort(messagePort)
  urlTransfer.SetHeaders(m.headers)
  
  postMethods = {"PUT":true,"POST":true,"PATCH":true}
  if postMethods.DoesExist(m.method) then
    urlTransfer.AsyncPostFromString(m.body)
  else
    urlTransfer.AsyncGetToString()
  end if
  m.urlTransfer = urlTransfer

  ' if async, return something the caller can pend on
  if synchronous then
    result = invalid
    while m.urlEvent = invalid
      message = wait(0, messagePort)
      result = m.handleEvent(message)
    end while
    return result
  else
    return m.urlTransfer.GetMessagePort()
  end if
End Function


' Cancel a running asynchronous request
Function request_cancel_()
  if m.urlTransfer <> invalid and type(m.urlTransfer) = "roUrlTransfer" then
    m.urlTransfer.AsyncCancel()
    m.urlTransfer = invalid
  end if
End Function


' Handle events here, but only treat network failures as Request errors
' Returns invalid if either the message doesn't match this request or
' there was a network error.  HTTP errors are treated as success here.
Function request_handleEvent_(message As Object) As Object
  ' Make sure the event matches the request
  if type(message) = "roUrlEvent" and m.urlTransfer.GetIdentity() = message.GetSourceIdentity() then
    m.urlEvent = message
    if message.GetResponseCode() > 0 then
      return message.GetString()
    else
      return invalid
    end if
  else
    return invalid
  end if
End Function
