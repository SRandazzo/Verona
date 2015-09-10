//
//  VeronaTests.swift
//  VeronaTests
//
//  Created by Salvatore Randazzo on 6/3/15.
//  Copyright (c) 2015 Salvatore Randazzo. All rights reserved.
//

import UIKit
import XCTest
import Verona
import FBSnapshotTestCase

class VeronaTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testItCreatesFontsCorrectly() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.Font(UIFont(name: "Optima-ExtraBlack", size: 18)!))
        }
        
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItCreatesParagraphStyleCorrectly() {
        
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .Right
            paragraph.lineSpacing = 20
            paragraph.lineBreakMode = NSLineBreakMode.ByCharWrapping
            make.setAttribute(.ParagraphStyle(paragraph))
        }
        let label = wrapAsLabel(string)
        label.frame.size = CGSize(width: 75, height: 100)
        label.numberOfLines = 0
        FBSnapShotVerifyLayer(label.layer)
    }
    
    
    func testItCreatesColorCorrectly() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.Color(UIColor.blueColor()))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItCreatesBackgroundColorCorrectly() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.BackgroundColor(UIColor.lightGrayColor()))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testLigature() {
        
        let string = "Ciao, Verona. Un Caffé?"
        let zapfino = UIFont(name: "Zapfino", size: 24) as UIFont!
        //Demonstrate no ligature vs ligature. Ligature is the joining of certain characters, such as 'ff'
        let ligatureString = NSAttributedString.make(string) { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.Ligature(true))
            make.setAttribute(.Font(zapfino))
        }
        
        let noLigatureString = NSAttributedString.make(string) { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.Ligature(false))
            make.setAttribute(.Font(zapfino))
        }
        
        let ligatureLabel = wrapAsLabel(ligatureString)
        let noLigatureLabel = wrapAsLabel(noLigatureString)
        let container = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ligatureLabel.frame.width, height: ligatureLabel.frame.height + noLigatureLabel.frame.height)))
        
        container.addSubview(ligatureLabel)
        noLigatureLabel.frame.offsetInPlace(dx: 0, dy: ligatureLabel.frame.height)
        container.addSubview(noLigatureLabel)
        
        FBSnapShotVerifyLayer(container.layer)
    }
    
    func testItKerns() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.Kerning(22))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }

    func testItStrikeThroughs() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.Strikethrough(NSUnderlineStyle.StyleSingle))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }

    func testItUnderlines() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.UnderlineStyle(NSUnderlineStyle.StyleSingle))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItStrokes() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.StrokeColor(UIColor.redColor()))
            make.setAttribute(.StrokeWidth(4))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItShadows() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.redColor()
            shadow.shadowBlurRadius = 8
            make.setAttribute(.Shadow(shadow))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }

    func testItsTextEffects() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.TextEffect(NSTextEffectAttributeStyle.LetterPressStyle))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
//    func testAttachments() {
//        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
//            let attachment = NSTextAttachment(data: <#NSData?#>, ofType: <#String?#>)
//            make.setAttribute(.TextEffect(NSTextEffectAttributeStyle.LetterPressStyle))
//        }
//        FBSnapShotVerifyLayer(wrap(string).layer)
//    }
    
    func testLinks() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.Link(NSURL(string: "www.cocoapods.org")!))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testStringLinks() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.LinkAsString("www.cocoapods.org"))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    
    func testBaseLineOffset() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.BaseLineOffset(10))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    
    func testItUnderlinesWithColors() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.UnderlineStyle(NSUnderlineStyle.StyleSingle))
            make.setAttribute(.UnderlineColor(UIColor.redColor()))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItStrikeThroughsWithColor() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.Strikethrough(NSUnderlineStyle.StyleSingle))
            make.setAttribute(.StrikethroughColor(UIColor.redColor()))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItsObliqueness() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.Obliqueness(2))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItsExpansion() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.Expansion(2))
        }
        FBSnapShotVerifyLayer(wrapAsLabel(string).layer)
    }

    //TODO: Unsure how to test/use writing direction
//    func testItsWritingDirection() {
//        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
//            make.setAttribute(.WritingDirection([NSTextWritingDirection.Override]))
//        }
//        FBSnapShotVerifyLayer(wrap(string).layer)
//    }
    
    //TODO: Unsure how to test/use GlyphForm
//    func testItsVerticalGlyphForm() {
//        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
//            make.setAttribute(.VerticalGlyphForm(VerticalGlyphFormDirection.Horizontal))
//        }
//        FBSnapShotVerifyLayer(wrap(string).layer)
//    }
  
    //Helper for snapshot tests
    func wrapAsLabel(string: NSAttributedString) -> UILabel {
        let label = UILabel()
        label.attributedText = string
        label.backgroundColor = UIColor.whiteColor()
        label.sizeToFit()
        return label
    }
}
