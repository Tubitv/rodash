# rodash
[Lodash](https://lodash.com/)-inspired utility functions for Roku Brightscript


##  Goals:

- reduce Lines of Code, and thus complexity, in brightscript applications
- facilitate better separation of business logic and data management
- provide solutions to common runtime errors (type mismatches, unexpected invalid objects)
- improve interfaces to standard Brightscript components
- be agnostic of SceneGraph vs. SDK1 applications
- have no other dependencies than the standard Brightscript components
- thoroughly tested and documented behavior

## Non-goals

- Application architecture
- Data modeling


## Areas

- Objects
- Strings
- Network
  - Requests
  - Uri
- Platform
  - Registry
  - Manifest
  - Display

## Example usage:

```
_ = rodash()
_.getManifest()                                             
  => { title: "My Roku App", ...}
  
_.get({ a: { b: 2}}, "b")                                   
  => 2
  
_.regWrite("auth", "oauth", { id: 1234, token: 5678 })      
  => n/a
  
_.regRead("auth", "oauth")                                  
  => { id: 1234, token: 5678 })

googleReq = _.createRequest("http://www.google.com")        
  => { <request object> }
  
googleReq.start(true)                                       
  => "<!doctype html><html..."
```

## API

#### intersection()

#### equal()

#### get()

#### set()

#### getManifest()

#### regRead()

#### regWrite()

#### regReadAll()

#### regWriteAll()

#### createRequest()

#### uriEncodeParams()

#### uriParse()