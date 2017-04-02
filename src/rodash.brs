' rodash - useful utilities for brightscript language
'
'  Goals:
'    - reduce Lines of Code, and thus complexity, in brightscript applications
'    - facilitate better separation of business logic and data management
'    - provide solutions to common runtime errors (type mismatches, unexpected invalid objects)
'    - improve interfaces to standard Brightscript components
'    - be agnostic of SceneGraph vs. SDK1 applications
'    - have no other dependencies than the standard Brightscript components
'
'  Areas:
'    - Objects
'    - Requests
'    - Uri
'    - Registry
'    - Manifest
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
    intersection: rodash_intersection_
    equal: rodash_equal_
    get: rodash_get_
    set: rodash_set_
    getManifest: rodash_getManifest_
    regRead: rodash_regRead_
    regWrite: rodash_regWrite_
    regReadAll: rodash_regReadAll_
    regWriteAll: rodash_regWriteAll_
    createRequest: rodash_createRequest_
    uriEncodeParams: rodash_uri_encodeParams_
    uriParse: rodash_uri_simpleParse_
    empty: rodash_empty_
    clone: rodash_clone_
    
    ' private
    pathAsArray_: rodash_pathAsArray_
    cloneNode_: rodash_cloneNode_
    cloneAssocArray_: rodash_cloneAssocArray_
  }
End Function
