''''''''''''''''
' Uri Module
'
' Primarily for providing wrangling of URI and query-/post-params
''''''''''''''''

' /**
'  * @member uriEncodeParams
'  * @memberof module:rodash
'  * @instance
'  * @description Encode an associative array to a urlencoded query string or post body
'  * @example
'  *
'  * _.uriEncodeParams({ a: 1, b: 2, c: "three", d: "four with spaces"})
'  * '  => "a=1&b=2&c=three&d=four%20with%20spaces"
'  */
Function rodash_uri_encodeParams_(params As Object) As String
  encoded = ""
  if params <> invalid and type(params) = "roAssociativeArray" then
    ' keys come out in lexigraphical order
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

    ' trim hanging ampersand
    if Right(encoded, 1) = "&" then 
      encoded = Left(encoded, Len(encoded)-1)
    end if
  end if
  return encoded
End Function


' /**
'  * @member uriParse
'  * @memberof module:rodash
'  * @instance
'  * @description Parse a string uri into its parts.
'  * @example
'  *
'  * _.uriParse("https://www.google.com/#q=bees")
'  * '  => { scheme: "https", host: "www.google.com", hash: ... }
'  *
'  */
Function rodash_uri_parse_(input)
  return m.uriSimpleParse_(input)
End Function


'''''''''''''''''
' simpleParse()
'
' Since in all likelihood we're only dealing with http:// or https://, we can
' do some very simple parsing
Function rodash_uri_simpleParse_(input As String)
  result = {
    scheme: ""
    port: ""
    hostname: ""
    pathname: ""
    search: ""
    hash: ""
  }

  ' scheme
  scheme_end = input.instr("//")
  if scheme_end = -1 then scheme_end = input.len()
  result.scheme = input.left(scheme_end)
  input = input.mid(scheme_end + 2)

  ' hostname
  hostname_end = input.instr(":")
  if hostname_end = -1 then
    hostname_end = input.instr("/")
    if hostname_end = -1 then hostname_end = input.len()
  end if
  result.hostname = input.left(hostname_end)
  input = input.mid(hostname_end)

  ' port?
  if input.Left(1) = ":" then
    port_end = input.instr("/")
    if port_end = -1 then port_end = input.len()
    result.port = input.mid(1, port_end-1)  ' take the ':' prefix off
    input = input.mid(port_end)
  end if

  ' path
  path_end = input.instr("?")
  if path_end = -1 then 
    path_end = input.instr("#")
    if path_end = -1 then path_end = input.len()
  end if
  result.pathname = input.left(path_end)
  input = input.mid(path_end)

  ' search?
  if input.left(1) = "?" then
    search_end = input.instr("#")
    if search_end = -1 then search_end = input.len()
    result.search = input.left(search_end)
    input = input.mid(search_end)
  end if

  ' hash 
  if input.left(1) = "#" then
    hash_end = input.len()
    result.hash = input.left(hash_end)
  end if
  
  return result
End Function
