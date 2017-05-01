# rodash
[Lodash](https://lodash.com/)-inspired utility functions for Roku Brightscript


## API Documentation

[API Documentation](https://cdthompson.github.io/rodash/module-rodash.html)


## Example usage:

```
_ = rodash()

' Safely find nested values without crashing on invalid intermediate objects
_.get({ a: { b: 2}}, "b")                                   
  => 2
  
' Safely compare types for equality, capturing TYPE_MISMATCH runtime errors
_.equal(invalid, "a")
  => false

' Write complex objects to the registry without manually serializing
_.regWrite("auth", "oauth", { id: 1234, token: 5678 })      
  => n/a
  
' Read complex objects from the registry without manual deserializing
_.regRead("auth", "oauth")                                  
  => { id: 1234, token: 5678 })

' Read in manifest file key/value pairs
_.getManifest()
  => { title: "My Roku App", ...}

' Encode URI params simply
url = "http://www.google.com/search?" + _.uriEncodeParams({q: "log lady", oq: "log lady", sourceid: "chrome", ie: "UTF-8"})

' Simple request object wraps roUrlTransfer
googleReq = _.createRequest(url, { method: "GET", body: "", headers: { "Accept", "*/*" })
  => <request object>
  
' Synchronous execution of request
googleReq.start(true)                                       
  => "<!doctype html><html..."
```

##  Goals:

- reduce total lines of code, and thus complexity, in brightscript applications
- facilitate better separation of business logic and data management
- provide safety for common runtime errors (type mismatches, unexpected invalid objects)
- supplement standard Brightscript components interfaces
- be SceneGaph agnostic (not a framework)
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

## Building rodash.cat.brs

This will generate a single .brs file suitable for inserting into a channel source tree.

    $ make dist
    
## Building API documentation

Creating the documentation requires npm to be installed and available to the Makefile.

    $ make doc
    
## Running tests

    $ export ROKU_DEV_TARGET=x.x.x.x
    $ export DEV_PASSWORD=xxxx
    $ make test

-----

## Roadmap

Q2Y17

- Goal: first release with critical features for use cases
    - safety
        - type mismatches and invalidity in equality statements
            - `_.equal`
        - nested ifs for deep object retrieval, e.g. `value = a.b.c.d`
            - `_.get`
            - `_.set`
        - node, array, and assocarray cloning
            - `_.clone`
            - `_.cloneDeep`
    - commonly created solutions
        - reading/writing registry
            - `_.regRead`
            - `_.regWrite`
            - `_.regReadAll`
            - `_.regWriteAll`
        - manifest reading
            - `_.manifestRead`
        - uri wrangling
            - `_.uriParse`
            - `_.uriEncodeParams`
        - string/array emptiness checks
            - `_.empty`
    - code clarity
        - multi-line conditional statements
            - `_.andx`
            - `_.orx`
        - conditional assignments
            - `_.cond`
- Goal: build system
    - Creation of single-file distributable
    - Unit test framework
    - Documentation generation
- Goal: Documentation
    - coding standards
    - contribution guidelines
    - release process
    - usage, examples, source links, test links
