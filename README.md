# rodash
[Lodash](https://lodash.com/)-inspired utility functions for Roku Brightscript


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

## API Documentation

[API Documentation](https://cdthompson.github.io/rodash/module-rodash.html)


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
