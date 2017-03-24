Function testSuite_Uri()
  this = BaseTestSuite()

  this.Name = "UriModuleTestSuite"

  this.addTest("encodeParams", testCase_Uri_encodeParams)
  this.addTest("encodeParams_order", testCase_Uri_encodeParams_order)
  this.addTest("encodeParams_escaping", testCase_Uri_encodeParams_escaping)
  this.addTest("encodeParams_array", testCase_Uri_encodeParams_array)
  this.addTest("parse", testCase_Uri_parse)
  return this
End Function

Function testCase_Uri_encodeParams()
  uri = UriModule()
  queryString = uri.encodeParams({ a: 1, b: 2, c: "three"})
  return m.AssertEqual(queryString, "a=1&b=2&c=three")
End Function

Function testCase_Uri_encodeParams_order()
  uri = UriModule()
  queryString = uri.encodeParams({ c: "three", a: 1, b: 2})
  return m.AssertEqual(queryString, "a=1&b=2&c=three")
End Function

Function testCase_Uri_encodeParams_escaping()
  uri = UriModule()
  queryString = uri.encodeParams({ a: "param with spaces"})
  return m.AssertEqual(queryString, "a=param%20with%20spaces")
End Function

Function testCase_Uri_encodeParams_array()
  uri = UriModule()
  queryString = uri.encodeParams({ "a[value]": "something"})
  return m.AssertEqual(queryString, "a[value]=something")
End Function

Function testCase_Uri_parse()
  ' Test cases grabbed from https://raw.githubusercontent.com/cweb/url-testing/master/urls.json
  'testUrls = ParseJson(ReadAsciiFile("pkg:/source/tests/urls.json"))

  testUrls = [
  {
    "url": "foo://example.com:8042/over/there?name=ferret#nose",
    "hash": "#nose",
    "host": "example.com:8042",
    "hostname": "example.com",
    "origin": "foo://example.com:8042",
    "pathname": "/over/there",
    "port": "8042",
    "scheme": "foo:",
    "search": "?name=ferret"
  },
'  {
'    "url": "urn:example:animal:ferret:nose",
'    "hash": "",
'    "host": "",
'    "hostname": "",
'    "origin": "urn://",
'    "pathname": "example:animal:ferret:nose",
'    "port": "",
'    "scheme": "urn:",
'    "search": ""
'  },
'  {
'    "url": "jdbc:mysql://test_user:ouupppssss@localhost:3306/sakila?profileSQL=true",
'    "hash": "",
'    "host": "",
'    "hostname": "",
'    "origin": "jdbc://",
'    "pathname": "mysql://test_user:ouupppssss@localhost:3306/sakila",
'    "port": "",
'    "scheme": "jdbc:",
'    "search": "?profileSQL=true"
'  },
  {
    "url": "ftp://ftp.is.co.za/rfc/rfc1808.txt",
    "hash": "",
    "host": "ftp.is.co.za",
    "hostname": "ftp.is.co.za",
    "origin": "ftp://ftp.is.co.za",
    "pathname": "/rfc/rfc1808.txt",
    "port": "",
    "scheme": "ftp:",
    "search": ""
  },
  {
    "url": "http://www.ietf.org/rfc/rfc2396.txt#header1",
    "hash": "#header1",
    "host": "www.ietf.org",
    "hostname": "www.ietf.org",
    "origin": "http://www.ietf.org",
    "pathname": "/rfc/rfc2396.txt",
    "port": "",
    "scheme": "http:",
    "search": ""
  },
'  {
'    "url": "ldap://[2001:db8::7]/c=GB?objectClass=one&objectClass=two",
'    "hash": "",
'    "host": "[2001:db8::7]",
'    "hostname": "[2001:db8::7]",
'    "origin": "ldap://[2001:db8::7]",
'    "pathname": "/c=GB",
'    "port": "",
'    "scheme": "ldap:",
'    "search": "?objectClass=one&objectClass=two"
'  },
'  {
'    "url": "mailto:John.Doe@example.com",
'    "hash": "",
'    "host": "",
'    "hostname": "",
'    "origin": "mailto://",
'    "pathname": "John.Doe@example.com",
'    "port": "",
'    "scheme": "mailto:",
'    "search": ""
'  },
'  {
'    "url": "news:comp.infosystems.www.servers.unix",
'    "hash": "",
'    "host": "",
'    "hostname": "",
'    "origin": "news://",
'    "pathname": "comp.infosystems.www.servers.unix",
'    "port": "",
'    "scheme": "news:",
'    "search": ""
'  },
'  {
'    "url": "tel:+1-816-555-1212",
'    "hash": "",
'    "host": "",
'    "hostname": "",
'    "origin": "tel://",
'    "pathname": "+1-816-555-1212",
'    "port": "",
'    "scheme": "tel:",
'    "search": ""
'  },
  {
    "url": "telnet://192.0.2.16:80/",
    "hash": "",
    "host": "192.0.2.16:80",
    "hostname": "192.0.2.16",
    "origin": "telnet://192.0.2.16:80",
    "pathname": "/",
    "port": "80",
    "scheme": "telnet:",
    "search": ""
  },
'  {
'    "url": "urn:oasis:names:specification:docbook:dtd:xml:4.1.2",
'    "hash": "",
'    "host": "",
'    "hostname": "",
'    "origin": "urn://",
'    "pathname": "oasis:names:specification:docbook:dtd:xml:4.1.2",
'    "port": "",
'    "scheme": "urn:",
'    "search": ""
'  },
'  {
'    "url": "ssh://alice@example.com",
'    "hash": "",
'    "host": "example.com",
'    "hostname": "example.com",
'    "origin": "ssh://example.com",
'    "pathname": "",
'    "port": "",
'    "scheme": "ssh:",
'    "search": ""
'  },
'  {
'    "url": "https://bob:pass@example.com/place",
'    "hash": "",
'    "host": "example.com",
'    "hostname": "example.com",
'    "origin": "https://example.com",
'    "pathname": "/place",
'    "port": "",
'    "scheme": "https:",
'    "search": ""
'  },
  {
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
  ]

  uri = UriModule()
  for each testCase in testUrls
    parsed = uri.parse(testCase.url)
    result = ""
    result = result + m.AssertEqual(parsed.scheme, testCase.scheme)
    result = result + m.AssertEqual(parsed.hostname, testCase.hostname)
    result = result + m.AssertEqual(parsed.port, testCase.port)
    result = result + m.AssertEqual(parsed.pathname, testCase.pathname)
    result = result + m.AssertEqual(parsed.search, testCase.search)
    result = result + m.AssertEqual(parsed.hash, testCase.hash)
    if result <> "" then return result
  end for
  return ""
End Function