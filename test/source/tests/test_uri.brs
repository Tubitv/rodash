Function testSuite_Uri()
  this = BaseTestSuite()
  this.Name = "UriModuleTestSuite"
  this.SetUp = uriTestSuite_setUp
  this.addTest("encodeParams", testCase_Uri_encodeParams)
  this.addTest("encodeParams_order", testCase_Uri_encodeParams_order)
  this.addTest("encodeParams_escaping", testCase_Uri_encodeParams_escaping)
  this.addTest("encodeParams_array", testCase_Uri_encodeParams_array)
  this.parseHelper = testCaseHelper_Uri_parse
  this.addTest("parse_a", testCase_Uri_parse_a)
  this.addTest("parse_b", testCase_Uri_parse_b)
  this.addTest("parse_c", testCase_Uri_parse_c)
  this.addTest("parse_d", testCase_Uri_parse_d)
  this.addTest("parse_e", testCase_Uri_parse_e)
  return this
End Function

Function uriTestSuite_setUp()
  m._ = rodash()
End Function

Function testCase_Uri_encodeParams()
  queryString = m._.uriEncodeParams({ a: 1, b: 2, c: "three"})
  return m.AssertEqual(queryString, "a=1&b=2&c=three")
End Function

Function testCase_Uri_encodeParams_order()
  queryString = m._.uriEncodeParams({ c: "three", a: 1, b: 2})
  return m.AssertEqual(queryString, "a=1&b=2&c=three")
End Function

Function testCase_Uri_encodeParams_escaping()
  queryString = m._.uriEncodeParams({ a: "param with spaces"})
  return m.AssertEqual(queryString, "a=param%20with%20spaces")
End Function

Function testCase_Uri_encodeParams_array()
  queryString = m._.uriEncodeParams({ "a[value]": "something"})
  return m.AssertEqual(queryString, "a[value]=something")
End Function



Function testCaseHelper_Uri_parse(testCase)
  parsed = m._.uriParse(testCase.url)
  result = ""
  result = result + m.AssertEqual(parsed.scheme, testCase.scheme)
  result = result + m.AssertEqual(parsed.hostname, testCase.hostname)
  result = result + m.AssertEqual(parsed.port, testCase.port)
  result = result + m.AssertEqual(parsed.pathname, testCase.pathname)
  result = result + m.AssertEqual(parsed.search, testCase.search)
  result = result + m.AssertEqual(parsed.hash, testCase.hash)
  return result
End Function


Function testCase_Uri_parse_a()
  case = {
    "url": "foo://example.com:8042/over/there?name=ferret#nose",
    "hash": "#nose",
    "host": "example.com:8042",
    "hostname": "example.com",
    "origin": "foo://example.com:8042",
    "pathname": "/over/there",
    "port": "8042",
    "scheme": "foo:",
    "search": "?name=ferret"
  }
  return m.parseHelper(case)
End Function

Function testCase_Uri_parse_b()
  case = {
    "url": "ftp://ftp.is.co.za/rfc/rfc1808.txt",
    "hash": "",
    "host": "ftp.is.co.za",
    "hostname": "ftp.is.co.za",
    "origin": "ftp://ftp.is.co.za",
    "pathname": "/rfc/rfc1808.txt",
    "port": "",
    "scheme": "ftp:",
    "search": ""
  }
  return m.parseHelper(case)
End Function

Function testCase_Uri_parse_c()
  case = {
    "url": "http://www.ietf.org/rfc/rfc2396.txt#header1",
    "hash": "#header1",
    "host": "www.ietf.org",
    "hostname": "www.ietf.org",
    "origin": "http://www.ietf.org",
    "pathname": "/rfc/rfc2396.txt",
    "port": "",
    "scheme": "http:",
    "search": ""
  }
  return m.parseHelper(case)
End Function

Function testCase_Uri_parse_d()
  case = {
    "url": "telnet://192.0.2.16:80/",
    "hash": "",
    "host": "192.0.2.16:80",
    "hostname": "192.0.2.16",
    "origin": "telnet://192.0.2.16:80",
    "pathname": "/",
    "port": "80",
    "scheme": "telnet:",
    "search": ""
  }
  return m.parseHelper(case)
End Function

Function testCase_Uri_parse_e()
  case = {
    "url": "http://example.com/?a=1&b=2+2&c=3&c=4&d=%65%6e%63%6F%64%65%64"
    "hash": "",
    "host": "example.com",
    "hostname": "example.com",
    "origin": "http://example.com",
    "pathname": "/",
    "port": "",
    "scheme": "http:",
    "search": "?a=1&b=2+2&c=3&c=4&d=%65%6e%63%6F%64%65%64"
  }
  return m.parseHelper(case)
End Function
