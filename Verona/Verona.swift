//
//  Verona.swift
//  Verona
//
//  Created by Salvatore Randazzo on 6/3/15.
//  Copyright (c) 2015 Salvatore Randazzo. All rights reserved.
//

import Foundation

public enum NSTextEffectAttributeStyle {
    case letterPressStyle
    
    public var attributedAttributeName: String {
        switch self {
        case .letterPressStyle:
            return NSTextEffectLetterpressStyle
        }
    }
}

public enum VerticalGlyphFormDirection: Int {
    case horizontal = 0
    case vertical = 1
}

public enum NSAttributedStringAttribute {
    
    case font(UIFont)
    case paragraphStyle(NSParagraphStyle)
    case color(UIColor)
    case backgroundColor(UIColor)
    case ligature(Bool)
    case kerning(CGFloat)
    //TODO: .PatternDot, .PatternDash, .PatternDashDot, PatternDashDotDot, .ByWord do not appear to work with StrikeThrough or Underline
    case strikethrough(NSUnderlineStyle)
    case underlineStyle(NSUnderlineStyle)
    case underlineColor(UIColor)
    case strikethroughColor(UIColor)
    case strokeColor(UIColor)
    case strokeWidth(CGFloat)
    case shadow(NSShadow)
    case textEffect(NSTextEffectAttributeStyle)
    case attachment(NSTextAttachment)
    case link(URL)
    case linkAsString(String)
    case baseLineOffset(CGFloat)
    case obliqueness(CGFloat)
    case expansion(CGFloat)
    case writingDirection([NSTextWritingDirection])
    case verticalGlyphForm(VerticalGlyphFormDirection) //1 vertical, 0 horiztonal
    
    public var attributedStringKeyValuePair: (key: String, value: Any) {
        switch self {
        case .font(let font):
            return (NSFontAttributeName, font)
        case .paragraphStyle(let style):
            return (NSParagraphStyleAttributeName, style)
        case .color(let color):
            return (NSForegroundColorAttributeName, color)
        case .backgroundColor(let color):
            return (NSBackgroundColorAttributeName, color)
        case .ligature(let ligature):
            return (NSLigatureAttributeName, ligature ? 1 : 0)
        case .kerning(let kerning):
            return (NSKernAttributeName, kerning as AnyObject)
        case .strikethrough(let strikethrough):
            return (NSStrikethroughStyleAttributeName, strikethrough.rawValue as AnyObject)
        case .underlineStyle(let underline):
            return (NSUnderlineStyleAttributeName, underline.rawValue as AnyObject)
        case .strokeColor(let color):
            return (NSStrokeColorAttributeName, color)
        case .strokeWidth(let width):
            return (NSStrokeWidthAttributeName, width as AnyObject)
        case .shadow(let shadow):
            return (NSShadowAttributeName, shadow)
        case .textEffect(let effect):
            return (NSTextEffectAttributeName, effect.attributedAttributeName as AnyObject)
        case .attachment(let attachment):
            return (NSAttachmentAttributeName, attachment)
        case .link(let link):
            return (NSLinkAttributeName, link as AnyObject)
        case .linkAsString(let link):
            return (NSLinkAttributeName, link as AnyObject)
        case .baseLineOffset(let offset):
            return (NSBaselineOffsetAttributeName, offset as AnyObject)
        case .underlineColor(let color):
            return (NSUnderlineColorAttributeName, color)
        case .strikethroughColor(let color):
            return (NSStrikethroughColorAttributeName, color)
        case .obliqueness(let obliqueness):
            return (NSObliquenessAttributeName, obliqueness as AnyObject)
        case .expansion(let expansion):
            return (NSExpansionAttributeName, expansion as AnyObject)
        case .writingDirection(let directions):
            return (NSWritingDirectionAttributeName, directions.map{ $0.rawValue })
        case .verticalGlyphForm(let glyphForm):
            return (NSVerticalGlyphFormAttributeName, glyphForm.rawValue as AnyObject)
        }
    }
}

open class NSAttributedStringAttributeBuilder {
    
    fileprivate var attributesDictionary: [String : Any] = [ : ]
    
    public init() { }
    
    open func setAttribute(_ attribute: NSAttributedStringAttribute) {
        let keyValuePair = attribute.attributedStringKeyValuePair
        attributesDictionary.updateValue(keyValuePair.value, forKey: keyValuePair.key)
    }
    
    open func attributedStringAttributesDictionary() -> [String: Any]? {
        return attributesDictionary
    }
}

public extension NSAttributedString {
    
    public class func make(_ string: String, make: ((_ make: NSAttributedStringAttributeBuilder) -> Void)) -> NSAttributedString {
        let builder = NSAttributedStringAttributeBuilder()
        make(builder)
        return NSAttributedString(string: string, attributes: builder.attributedStringAttributesDictionary())
    }
}
