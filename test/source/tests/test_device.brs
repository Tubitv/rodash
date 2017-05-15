Function testSuite_getDeviceProfile()
  this = BaseTestSuite()
  this.Name = "GetDeviceProfileTestSuite"
  this.addTest("getDeviceProfile", testCase_getDeviceProfile)
  return this
End Function

Function testCase_getDeviceProfile() As String
  _ = rodash()
  profile = _.getDeviceProfile()
  result = m.AssertNotInvalid(profile)
  result = result + m.AssertNotInvalid(profile.deviceInfo)
  result = result + m.AssertTrue(profile.deviceInfo.count() = 26)
  result = result + m.AssertNotInvalid(profile.appInfo)
  result = result + m.AssertTrue(profile.appInfo.count() = 6)
  return result
End Function