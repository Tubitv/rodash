' VERSION: rodash 0.3.4
' LICENSE: Permission is hereby granted, free of charge, to any person obtaining
' LICENSE: a copy of this software and associated documentation files (the
' LICENSE: "Software"), to deal in the Software without restriction, including
' LICENSE: without limitation the rights to use, copy, modify, merge, publish,
' LICENSE: distribute, sublicense, and/or sell copies of the Software, and to
' LICENSE: permit persons to whom the Software is furnished to do so, subject to
' LICENSE: the following conditions:
' LICENSE: 
' LICENSE: The above copyright notice and this permission notice shall be
' LICENSE: included in all copies or substantial portions of the Software.
' LICENSE: 
' LICENSE: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
' LICENSE: EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
' LICENSE: MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
' LICENSE: NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
' LICENSE: LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
' LICENSE: OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
' LICENSE: WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Function rodash_cloneNode_(source)
blacklistedFields = ["change", "focusedChild"]  ' read-only fields
destination = CreateObject("roSGNode", source.subtype())
fields = source.getFields()
for each f in blacklistedFields
fields.delete(f)
end for
destination.setFields(fields)
return destination
End Function
Function rodash_cloneAssocArray_(source)
destination = {}
for each key in source
destination[key] = source[key]
end for
return destination
End Function
Function rodash_cloneArrayish_(source)
if type(source) = "roArray"
destination = CreateObject(type(source), 0, true)
else
destination = CreateObject(type(source))
end if
destination.Append(source)
return destination
End Function
Function rodash_cloneStringish_(source)
destination = CreateObject("roString")
destination.SetString(source.GetString())
if type(source) = "roString"
return destination
else if type(source) = "String"
return destination.GetString()
end if
End Function
Function rodash_clone_(source)
if source <> invalid 
if type(source) = "roSGNode"
return m.cloneNode_(source)
else if type(source) = "roAssociativeArray"
return m.cloneAssocArray_(source)
else if GetInterface(source, "ifArray") <> invalid
return m.cloneArrayish_(source)
else if (type(source) = "roString") or (type(source) = "String")
return m.cloneStringish_(source)
else
if type(Box(source)) <> type(source)
return source
else if type(source) = "roInt"
return Box(source.GetInt())
else if type(source) = "roLongInt"
return Box(source.GetLongInt())
else if type(source) = "roFloat"
return Box(source.GetFloat())
else if type(source) = "roDouble"
return Box(source.GetDouble())
else if type(source) = "roBoolean"
return Box(source.GetBoolean())
else
return invalid
end if
end if
end if
return invalid
End Function
Function rodash_cloneDeep_(source)
newTree = m.clone(source)
for i=0 to source.getChildCount()-1
newTree.appendChild(m.cloneDeep(source.getChild(i)))
end for
return newTree
End Function
Function rodash_cond_(expression, t, f)
if expression
return t
else
return f
end if
End Function
Function rodash_createRequest_(url As String, options={} As Object) As Object
if Left(LCase(url), 5) = "https" then
https = true
else
https = false
end if
validMethods = {"GET":true, "PUT":true, "POST":true, "DELETE":true, "PATCH":true}
if options <> invalid and options.method <> invalid and validMethods.DoesExist(UCase(options.method)) then
method = UCase(options.method)
else
method = "GET"
end if
if options <> invalid and options.headers <> invalid and type(options.headers) = "roAssociativeArray" then
headers = options.headers
else
headers = {}
end if
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
start: rodash_request_start_
cancel: rodash_request_cancel_
handleEvent: rodash_request_handleEvent_
}
End Function
Function rodash_request_start_(synchronous=false As Boolean, messagePort=invalid As Object) As Object
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
Function rodash_request_cancel_()
if m.urlTransfer <> invalid and type(m.urlTransfer) = "roUrlTransfer" then
m.urlTransfer.AsyncCancel()
m.urlTransfer = invalid
end if
End Function
Function rodash_request_handleEvent_(message As Object) As Object
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
Function rodash_getDeviceProfile_() As Object
ai = CreateObject("roAppInfo")
di = CreateObject("roDeviceInfo")
if FindMemberFunction(di, "GetChannelClientId") <> invalid
uniqueId = di.GetChannelClientId()
else if FindMemberFunction(di, "GetPublisherId") <> invalid
uniqueId = di.GetPublisherId()
else
uniqueId = ""
end if
if FindMemberFunction(di, "GetRIDA") <> invalid
adId = di.GetRIDA()
else
adId = ""
end if
if FindMemberFunction(di, "IsRIDADisabled") <> invalid
tracking = di.IsRIDADisabled()
else 
tracking = false
end if
profile =  {
appInfo: {
id: ai.GetID()
version: ai.GetVersion()
title: ai.GetTitle()
subtitle: ai.GetSubtitle()
devid: ai.GetDevID()
isDev: ai.IsDev()
}
deviceInfo: {
model: di.GetModel()
modelDetails: di.GetModelDetails()
modelDisplayName: di.GetModelDisplayName()
friendlyName: di.GetFriendlyName()
version: di.GetOSVersion().major + "." + di.GetOSVersion().minor + di.GetOSVersion().build
uniqueId: uniqueId
advertisingId: adId
adTrackingDisabled: tracking
trackingId: uniqueId
timeZone: di.GetTimeZone()
features: {
"5.1_surround_sound": di.HasFeature("5.1_surround_sound")
"can_output_5.1_surround_sound": di.HasFeature("can_output_5.1_surround_sound")
"sd_only_hardware": di.HasFeature("sd_only_hardware")
"usb_hardware": di.HasFeature("usb_hardware")
"1080p_hardware": di.HasFeature("1080p_hardware")
"sdcard_hardware": di.HasFeature("sdcard_hardware")
"ethernet_hardware": di.HasFeature("ethernet_hardware")
"gaming_hardware": di.HasFeature("gaming_hardware")
"bluetooth_hardware": di.HasFeature("bluetooth_hardware")
}
locale: di.GetCurrentLocale()
country: di.GetCountryCode()
drm: di.GetDrmInfoEx()
displayType: di.GetDisplayType()
displayMode: di.GetDisplayMode()
displayAspectRatio: di.GetDisplayAspectRatio()
displaySize: di.GetDisplaySize()
videoMode: di.GetVideoMode()
displayProperties: di.GetDisplayProperties()
supportedGraphicsResolutions: di.GetSupportedGraphicsResolutions()
uiResolution: di.GetUIResolution()
graphicsPlatform: di.GetGraphicsPlatform()
videoDecodeInfo: {} 'deprecated
audioOutputChannel: di.GetAudioOutputChannel()
audioDecodeInfo: {} 'deprecated
}
}
return profile
End Function
Function rodash_difference_(first, second)
result = []  
for each f in first
result.push(f)
for each s in second
if m.equal(s,f) then result.pop()
end for
end for
return result
End Function
Function rodash_empty_(value)
if value = invalid then return true
if GetInterface(value, "ifAssociativeArray") <> invalid
return (value.count() = 0)
else if GetInterface(value, "ifArray") <> invalid
return (value.count() = 0)
else if (type(value) = "roString") or (type(value) = "String")
return (value = "")  ' works for native and object strings
end if
return false
End Function
Function rodash_equal_(a, b)
all = {
"rosgnode": true
"rofunction": true
"invalid": true
"roarray": true
"roassociativearray": true
}
incomparable = {
"string": {
"integer": true
"rointeger": true
"boolean": true
"roboolean": true
"roarray": true
"roassociativearray": true
"longinteger": true
"rofloat": true
}
"rostring": {
"integer": true
"rointeger": true
"boolean": true
"roboolean": true
"roarray": true
"roassociativearray": true
"longinteger": true
"rofloat": true
}
}
atype = lcase(type(a))
btype = lcase(type(b))
if all[atype] = invalid and all[btype] = invalid
if incomparable[lcase(type(a))] = invalid or incomparable[lcase(type(a))][lcase(type(b))] = invalid 
if incomparable[lcase(type(b))] = invalid or incomparable[lcase(type(b))][lcase(type(a))] = invalid
if a = b
return true
else if type(a) = type(b) and type(a) = invalid 
return true
end if
end if
end if
end if
return false
End Function
Function rodash_get_(array, path, default=invalid)
if array = invalid or not (type(array) = "roAssociativeArray" or type(array) = "roArray") then return default
segments = m.pathAsArray_(path)
if segments = invalid then return default
result = invalid
while segments.count() > 0
key = segments.shift()
value = array[key]
if value = invalid
exit while
end if
if segments.count() = 0
result = value
exit while
end if
if not (type(value) = "roAssociativeArray" or type(value) = "roArray")
exit while
end if
array = value
end while
if result = invalid then return default
return result
End Function
Function rodash_indexOf_(array, value)
if array = invalid or value = invalid or GetInterface(array, "ifArray") = invalid then return -1
for i=0 to array.count()-1
if m.equal(array[i], value) then return i
end for
return -1
End Function
Function rodash_intersection_(first, second)
result = []  
for each f in first
for each s in second
if m.equal(s,f) then result.push(f)
end for
end for
return result
End Function
Function rodash_getManifest_(path="pkg:/manifest" As String)
file = ReadAsciiFile(path)
lines = file.split(Chr(10))
manifest = {}
for each line in lines
line = line.trim()
if line.left(1) <> "#" and line.len() <> 0 then
equal = line.instr(0, "=")
if equal = -1 then equal = line.len()
key = line.left(equal)
value = line.mid(equal+1)
manifest[key] = value
end if
end for
return manifest
End Function
Function rodash_map_(object, fn)
if type(fn) <> "Function"
fn = Function(x): return x: End FUnction
end if
if GetInterface(object, "ifArray") <> invalid
result = []
for each o in object
result.push(fn(o))
end for
return result
else
return []
end if
End Function
Function rodash_max_(a,b)
comparable = [
"integer"
"rointeger"
"roint"
"float"
"rofloat"
"double"
"rodouble"
]
for i=0 to comparable.count()-1
if lcase(type(a)) = comparable[i]
exit for
end if
end for
if i = comparable.count()
return b
end if
for j=0 to comparable.count()-1
if lcase(type(b)) = comparable[j]
exit for
end if
end for
if j = comparable.count()
return a
end if
if a >= b
return a
else
return b
end if
End Function
Function rodash_min_(a,b)
comparable = [
"integer"
"rointeger"
"roint"
"float"
"rofloat"
"double"
"rodouble"
]
for i=0 to comparable.count()-1
if lcase(type(a)) = comparable[i]
exit for
end if
end for
if i = comparable.count()
return b
end if
for j=0 to comparable.count()-1
if lcase(type(b)) = comparable[j]
exit for
end if
end for
if j = comparable.count()
return a
end if
if a <= b
return a
else
return b
end if
End Function
Function rodash_pathAsArray_(path)
pathRE = CreateObject("roRegex", "\[([0-9]+)\]", "i")
segments = []
if type(path) = "String" or type(path) = "roString"
dottedPath = pathRE.replaceAll(path, ".\1")
stringSegments = dottedPath.tokenize(".")
for each s in stringSegments
if (Asc(s) >= 48) and (Asc(s) <= 57)
segments.push(s.toInt())
else
segments.push(s)
end if
end for
else if type(path) = "roList" or type(path) = "roArray"
stringPath = ""
for each s in path
stringPath = stringPath + "." + Box(s).toStr()
end for
segments = m.pathAsArray_(stringPath)
else
segments = invalid
end if
return segments
End Function
Function rodash_regRead_(sectionName As String, key As String) As Dynamic
sectionName = LCase(sectionName)
key = LCase(key)
registry = CreateObject("roRegistry")  
section = CreateObject("roRegistrySection", sectionName)
if section.Exists(key) then
return ParseJson(section.Read(key))
else
return invalid
end if
End Function
Function rodash_regWrite_(sectionName As String, key As String, value As Dynamic) As Void
sectionName = LCase(sectionName)
key = LCase(key)
registry = CreateObject("roRegistry")  
section = CreateObject("roRegistrySection", sectionName)
section.Write(key, FormatJson(value))
section.Flush()
registry.Flush()
End Function
Function rodash_regDelete_(sectionName As String, key As String) As Void
sectionName = LCase(sectionName)
key = LCase(key)
registry = CreateObject("roRegistry")
section = CreateObject("roRegistrySection", sectionName)
if section.Exists(key) then section.Delete(key)
section.Flush()
registry.Flush()
End Function
Function rodash_regReadAll_() As Object
registry = CreateObject("roRegistry")
sections = registry.GetSectionList()
data = {}
for each sectionName in sections
section = CreateObject("roRegistrySection", sectionName)
keys = section.GetKeyList()
sectionData = {}
for each k in keys
sectionData[k] = ParseJson(section.Read(k))
end for
data[sectionName] = sectionData
end for
return data
End Function
Function rodash_regWriteAll_(data As Object) As Void
registry = CreateObject("roRegistry")
if data <> invalid and type(data) = "roAssociativeArray" then
for each sectionName in data
sectionData = data[sectionName]
sectionName = LCase(Box(sectionName.toStr())) ' force it to a roString
section = CreateObject("roRegistrySection", sectionName)
if sectionData <> invalid and type(sectionData) = "roAssociativeArray" then
for each key in sectionData
value = sectionData[key]
key = LCase(Box(key.toStr()))
section.Write(key, FormatJson(value))
end for
end if
section.Flush()
end for
end if
registry.Flush()
End Function
Function rodash_regDeleteAll_() As Void
registry = CreateObject("roRegistry")
sections = registry.GetSectionList()
for each sectionName in sections
registry.Delete(sectionName)
end for
registry.Flush()
End Function
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
pathAsArray_: rodash_pathAsArray_
cloneNode_: rodash_cloneNode_
cloneAssocArray_: rodash_cloneAssocArray_
cloneArrayish_: rodash_cloneArrayish_
cloneStringish_: rodash_cloneStringish_
uriSimpleParse_: rodash_uri_simpleParse_
}
End Function
Function rodash_set_(aa, path, value)
if aa = invalid or type(aa) <> "roAssociativeArray" then return aa
segments = m.pathAsArray_(path)
if segments = invalid then return aa
walk = aa
while segments.count() > 0
key = segments.shift()
if segments.count() = 0
walk.addReplace(key, value)
exit while
end if
lookup = walk.lookup(key)
if lookup = invalid or type(lookup) <> "roAssociativeArray"
walk.addReplace(key, {})
end if
walk = walk.lookup(key)
end while
return aa
End Function
Function rodash_uri_encodeParams_(params As Object) As String
encoded = ""
if params <> invalid and type(params) = "roAssociativeArray" then
for each param in params.Keys()
value = params[param]
if value = invalid then
value = ""
else
value = value.toStr()  ' force to roString
if FindMemberFunction(value, "EncodeUriComponent") <> invalid then
value = value.EncodeUriComponent()          
else
transferEncoder = CreateObject("roUrlTransfer")
value = transferEncoder.Escape(value)
end if
end if
encoded = encoded + param.toStr() + "=" + value + "&"
end for
if Right(encoded, 1) = "&" then 
encoded = Left(encoded, Len(encoded)-1)
end if
end if
return encoded
End Function
Function rodash_uri_parse_(input)
return m.uriSimpleParse_(input)
End Function
Function rodash_uri_simpleParse_(input As String)
result = {
scheme: ""
port: ""
hostname: ""
pathname: ""
search: ""
hash: ""
}
scheme_end = input.instr("//")
if scheme_end = -1 then scheme_end = input.len()
result.scheme = input.left(scheme_end)
input = input.mid(scheme_end + 2)
hostname_end = input.instr(":")
if hostname_end = -1 then
hostname_end = input.instr("/")
if hostname_end = -1 then hostname_end = input.len()
end if
result.hostname = input.left(hostname_end)
input = input.mid(hostname_end)
if input.Left(1) = ":" then
port_end = input.instr("/")
if port_end = -1 then port_end = input.len()
result.port = input.mid(1, port_end-1)  ' take the ':' prefix off
input = input.mid(port_end)
end if
path_end = input.instr("?")
if path_end = -1 then 
path_end = input.instr("#")
if path_end = -1 then path_end = input.len()
end if
result.pathname = input.left(path_end)
input = input.mid(path_end)
if input.left(1) = "?" then
search_end = input.instr("#")
if search_end = -1 then search_end = input.len()
result.search = input.left(search_end)
input = input.mid(search_end)
end if
if input.left(1) = "#" then
hash_end = input.len()
result.hash = input.left(hash_end)
end if
return result
End Function
