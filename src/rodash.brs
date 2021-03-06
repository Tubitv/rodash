' /**
'  * @module rodash
'  */
Function rodash()
  return {
    intersection: rodash_intersection_
    difference: rodash_difference_
    equal: rodash_equal_
    get: rodash_get_
    set: rodash_set_
    getManifest: rodash_getManifest_
    regRead: rodash_regRead_
    regWrite: rodash_regWrite_
    regDelete: rodash_regDelete_
    regReadAll: rodash_regReadAll_
    regWriteAll: rodash_regWriteAll_
    regDeleteAll: rodash_regDeleteAll_
    createRequest: rodash_createRequest_
    uriEncodeParams: rodash_uri_encodeParams_
    uriParse: rodash_uri_parse_
    empty: rodash_empty_
    clone: rodash_clone_
    cloneDeep: rodash_cloneDeep_
    cond: rodash_cond_
    map: rodash_map_
    indexOf: rodash_indexOf_
    min: rodash_min_
    max: rodash_max_
    getDeviceProfile: rodash_getDeviceProfile_
    
    ' private
    pathAsArray_: rodash_pathAsArray_
    cloneNode_: rodash_cloneNode_
    cloneAssocArray_: rodash_cloneAssocArray_
    cloneArrayish_: rodash_cloneArrayish_
    cloneStringish_: rodash_cloneStringish_
    uriSimpleParse_: rodash_uri_simpleParse_
  }
End Function
