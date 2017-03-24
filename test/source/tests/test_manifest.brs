Function testSuite_Manifest()
  this = BaseTestSuite()

  this.Name = "ManifestTestSuite"
  this.addTest("get", testCase_Manifest_get)
  return this
End Function

Function testCase_Manifest_getManifest() As String
  manifest = ManifestModule()
  result = manifest.get("pkg:/source/tests/fake_manifest")
  return m.AssertEqual(result.count(), 39)
End Function
