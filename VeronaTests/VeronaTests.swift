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
            make.setAttribute(.font(UIFont(name: "Optima-ExtraBlack", size: 18)!))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItCreatesParagraphStyleCorrectly() {
        
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .right
            paragraph.lineSpacing = 20
            paragraph.lineBreakMode = NSLineBreakMode.byCharWrapping
            make.setAttribute(.paragraphStyle(paragraph))
        }
        let label = wrapAsLabel(string)
        label.frame.size = CGSize(width: 75, height: 100)
        label.numberOfLines = 0
        FBSnapshotVerifyLayer(label.layer)
    }
    
    
    func testItCreatesColorCorrectly() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.color(UIColor.blue))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItCreatesBackgroundColorCorrectly() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.backgroundColor(UIColor.lightGray))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testLigature() {
        
        let string = "Ciao, Verona. Un Caffé?"
        let zapfino = UIFont(name: "Zapfino", size: 24)
        
        //Demonstrate no ligature vs ligature. Ligature is the joining of certain characters, such as 'ff'
        let ligatureString = NSAttributedString.make(string) { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.ligature(true))
            make.setAttribute(.font(zapfino!))
        }
        
        let noLigatureString = NSAttributedString.make(string) { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.ligature(false))
            make.setAttribute(.font(zapfino!))
        }
        
        let ligatureLabel = wrapAsLabel(ligatureString)
        let noLigatureLabel = wrapAsLabel(noLigatureString)
        let container = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: ligatureLabel.frame.width, height: ligatureLabel.frame.height + noLigatureLabel.frame.height)))
        
        container.addSubview(ligatureLabel)
        
        noLigatureLabel.frame = noLigatureLabel.frame.offsetBy(dx: 0, dy: ligatureLabel.frame.height)
        
        container.addSubview(noLigatureLabel)
        
        FBSnapshotVerifyLayer(container.layer)
    }
    
    func testItKerns() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.kerning(22))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }

    func testItStrikeThroughs() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.strikethrough(NSUnderlineStyle.styleSingle))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }

    func testItUnderlines() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.underlineStyle(NSUnderlineStyle.styleSingle))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItStrokes() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.strokeColor(UIColor.red))
            make.setAttribute(.strokeWidth(4))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItShadows() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.red
            shadow.shadowBlurRadius = 8
            make.setAttribute(.shadow(shadow))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }

    func testItsTextEffects() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.textEffect(NSTextEffectAttributeStyle.letterPressStyle))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
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
            make.setAttribute(.link(URL(string: "www.cocoapods.org")!))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testStringLinks() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.linkAsString("www.cocoapods.org"))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    
    func testBaseLineOffset() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.baseLineOffset(10))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    
    func testItUnderlinesWithColors() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.underlineStyle(NSUnderlineStyle.styleSingle))
            make.setAttribute(.underlineColor(UIColor.red))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItStrikeThroughsWithColor() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.strikethrough(NSUnderlineStyle.styleSingle))
            make.setAttribute(.strikethroughColor(UIColor.red))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItsObliqueness() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.obliqueness(2))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
    }
    
    func testItsExpansion() {
        let string = NSAttributedString.make("Ciao, Verona") { (make: NSAttributedStringAttributeBuilder) -> Void in
            make.setAttribute(.expansion(2))
        }
        FBSnapshotVerifyLayer(wrapAsLabel(string).layer)
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
    func wrapAsLabel(_ string: NSAttributedString) -> UILabel {
        let label = UILabel()
        label.attributedText = string
        label.backgroundColor = UIColor.white
        label.sizeToFit()
        return label
    }
}
