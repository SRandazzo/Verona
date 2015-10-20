[![Build Status](https://travis-ci.org/SRandazzo/Verona.svg)](https://travis-ci.org/SRandazzo/Verona) [![codecov.io](http://codecov.io/github/SRandazzo/Verona/coverage.svg?branch=master)](http://codecov.io/github/SRandazzo/Verona?branch=master)

#Verona
Verona is a microframework for elegantly creating `NSAttributedString` in Swift.

Verona makes it easy to create `NSAttributedString` in a typesafe manner that doesn't require memorizing or looking up attribute names.  

##Usage

All `NSAttributedString` attributes are available as a Swift enum with associated values of their intended type, which makes easy and safe to use.

```Swift
case Font(UIFont)
case ParagraphStyle(NSParagraphStyle)
case Color(UIColor)
case BackgroundColor(UIColor)
case Ligature(Bool)
case Kerning(Int)
...etc
```


###Make Closure
The easiest way to create `NSAttributedString` is via the built in extension which provides a `make` closure
```Swift

let attributedString = NSAttributedString.make("Ciao, Verona", make: { (make: NSAttributedStringAttributeBuilder) -> Void in
    make.setAttribute(.Font(UIFont(name: "HelveticaNeue", size: 18)!))
    make.setAttribute(NSAttributedStringAttribute.Kerning(3))
    make.setAttribute(NSAttributedStringAttribute.Color(UIColor.blueColor()))
})

```

###Directly using the builder
You can directly use the underlying `NSAttributedStringAttributeBuilder` to generate attribute dictionaries

```Swift
let builder = NSAttributedStringAttributeBuilder()
builder.setAttribute(.Font(UIFont(name: "HelveticaNeue", size: 18)!))
builder.setAttribute(NSAttributedStringAttribute.Kerning(1))

let attString = NSAttributedString(string: string, attributes: builder.attributedStringAttributesDictionary())

```

###Tests
Verona is currently unit tested using FBSnapshotTestCase for all cases. To run the unit tests, be sure to run cocoapods first.
Test results can be found here: https://github.com/SRandazzo/Verona/tree/master/VeronaTests/ReferenceImages/VeronaTests.VeronaTests

All tests should be run against the `iPhone 6 iOS 9.0`

##Try it out
The easiest way to try out Verona is through the included Playground `TryVerona.playground`

To setup the project for development + tests, clone this repo, `cd` into Verona and run `make bootstrap`

##Contributing
Enjoying Verona!? We can use your help!
The following guidelines have been adopted from AshFurrow/Moya (https://github.com/ashfurrow/Moya):

Open source isn't just writing code. Verona could use your help with any of the following:

- Finding (and reporting!) bugs.
- New feature suggestions.
- Answering questions on issues.
- Documentation improvements.
- Reviewing pull requests.
- Helping to manage issue priorities.
- Fixing bugs/new features.

If any of that sounds cool to you, send a pull request! After a few contributions, we'll add you as admins to the repo so you can merge pull requests :tada:


##License
Verona is released under an MIT license. See LICENSE for more information.
