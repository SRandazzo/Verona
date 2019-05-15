//: Verona -

import Foundation
import UIKit
import Verona

//: The easiest way to use Verona is the `make` closure, which is an extension on NSAttributedString
let helloVerona = "Welcome to Verona! There are a few ways to use Verona. The first is an extension on NSAttributedString that provides a `make` closure to configure your string."

let attributedString = NSAttributedString.make(helloVerona, make: { (make) -> Void in
    make.setAttribute(.font(UIFont(name: "HelveticaNeue", size: 18)!))
    make.setAttribute(.kerning(3))
    make.setAttribute(.color(UIColor(red: 163/255.0, green: 133/255, blue: 70/255, alpha: 1.0)))
})


//: You can also use the builder directly
let alternatively = "Alternatively, you can use the builder directly to configure your attributed string, then ask the builder for the NSAttributedString formatted dictionary"

let builder = NSAttributedStringAttributeBuilder()
builder.setAttribute(.font(UIFont(name: "HelveticaNeue", size: 18)!))
builder.setAttribute(.kerning(1))
builder.setAttribute(.underlineStyle(NSUnderlineStyle.double))
builder.setAttribute(.color(UIColor.green))

let string = NSAttributedString(string: alternatively, attributes: builder.attributedStringAttributesDictionary())


//: Applying generators within a range

let redBuilder = NSAttributedStringAttributeBuilder()
redBuilder.setAttribute(.font(UIFont(name: "HelveticaNeue", size: 18)!))
redBuilder.setAttribute(.kerning(4))
redBuilder.setAttribute(.underlineStyle(NSUnderlineStyle.single))
redBuilder.setAttribute(.color(UIColor.red))

let partialString = NSMutableAttributedString(string: "In this example, we are only applying attributes to a part of the string")

let midPoint = partialString.length/2

partialString.setAttributes(builder.attributedStringAttributesDictionary(), range: NSMakeRange(0, midPoint))
partialString.setAttributes(redBuilder.attributedStringAttributesDictionary(), range: NSMakeRange(midPoint, partialString.length-midPoint))





