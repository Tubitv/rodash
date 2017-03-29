' rodash - useful utilities for brightscript language
'
' Example usage:
'   
'  _ = rodash()
'  _.getManifest()                                             => { title: "My Roku App", ...}
'  _.get({ a: { b: 2}}, "b")                                   => 2
'  _.regWrite("auth", "oauth", { id: 1234, token: 5678 })      => n/a
'  _.regRead("auth", "oauth")                                  => { id: 1234, token: 5678 })
'
'  googleReq = _.createRequest("http://www.google.com")        => { <request> }
'  googleReq.start(true)                                       => "<!doctype html><html..."
'


Function rodash()
  return {
    ' array.brs
    intersection: arrayModule_intersection_
    equal: arrayModule_equal_

    ' assocarray.brs
    pathAsArray_: assocArrayModule_pathAsArray_
    get: assocArrayModule_get_
    set: assocArrayModule_set_

    ' manifest.brs
    getManifest: manifestModule_getManifest_

    ' registry.brs
    regRead: registryModule_read_
    regWrite: registryModule_write_
    regReadAll: registryModule_readAll_
    regWriteAll: registryModule_writeAll_

    ' request.brs
    createRequest: request_createRequest_
    start_: request_start_
    cancel_: request_cancel_
    handleEvent_: request_handleEvent_

    ' uri.brs
    encodeParams: uri_encodeParams_
    parse: uri_simpleParse_
  }
End Function
