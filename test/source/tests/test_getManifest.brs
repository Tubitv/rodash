Function testSuite_getManifest()
  this = BaseTestSuite()
  this.Name = "GetManifestTestSuite"
  this.addTest("getManifest_default", testCase_getManifest_default)
  this.addTest("getManifest_path", testCase_getManifest_path)
  return this
End Function

Function testCase_getManifest_default() As String
  _ = rodash()
  result = _.getManifest()
  return m.AssertTrue(result.count() > 0)
End Function

Function testCase_getManifest_path() As String
  _ = rodash()
  result = _.getManifest("pkg:/source/tests/fake_manifest")
  return m.AssertEqual(result.count(), 39)
End Function