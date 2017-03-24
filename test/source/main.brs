Function Main()
  runner = TestRunner()
  runner.SetTestFilePrefix("test_")
  runner.SetTestSuitePrefix("testSuite_")
  runner.SetTestsDirectory("pkg:/source/tests")
  runner.Run()
End Function