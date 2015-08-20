//
//  Verona.swift
//  Verona
//
//  Created by Salvatore Randazzo on 6/3/15.
//  Copyright (c) 2015 Salvatore Randazzo. All rights reserved.
//

import Foundation

public enum NSTextEffectAttributeStyle {
    case LetterPressStyle
    
    public var attributedAttributeName: String {
        switch self {
        case .LetterPressStyle:
            return NSTextEffectLetterpressStyle
        }
    }
}

public enum VerticalGlyphFormDirection: Int {
    case Horizontal = 0
    case Vertical = 1
}

public enum NSAttributedStringAttribute {
    
    case Font(UIFont)
    case ParagraphStyle(NSParagraphStyle)
    case Color(UIColor)
    case BackgroundColor(UIColor)
    case Ligature(Bool)
    case Kerning(CGFloat)
    //TODO: .PatternDot, .PatternDash, .PatternDashDot, PatternDashDotDot, .ByWord do not appear to work with StrikeThrough or Underline
    case Strikethrough(NSUnderlineStyle)
    case UnderlineStyle(NSUnderlineStyle)
    case UnderlineColor(UIColor)
    case StrikethroughColor(UIColor)
    case StrokeColor(UIColor)
    case StrokeWidth(CGFloat)
    case Shadow(NSShadow)
    case TextEffect(NSTextEffectAttributeStyle)
    case Attachment(NSTextAttachment)
    case Link(NSURL)
    case LinkAsString(String)
    case BaseLineOffset(CGFloat)
    case Obliqueness(CGFloat)
    case Expansion(CGFloat)
    case WritingDirection([NSTextWritingDirection])
    case VerticalGlyphForm(VerticalGlyphFormDirection) //1 vertical, 0 horiztonal
    
    public var attributedStringKeyValuePair: (key: String, value: AnyObject) {
        switch self {
        case .Font(let font):
            return (NSFontAttributeName, font)
        case .ParagraphStyle(let style):
            return (NSParagraphStyleAttributeName, style)
        case .Color(let color):
            return (NSForegroundColorAttributeName, color)
        case .BackgroundColor(let color):
            return (NSBackgroundColorAttributeName, color)
        case .Ligature(let ligature):
            return (NSLigatureAttributeName, Int(ligature))
        case .Kerning(let kerning):
            return (NSKernAttributeName, kerning)
        case .Strikethrough(let strikethrough):
            return (NSStrikethroughStyleAttributeName, strikethrough.rawValue)
        case .UnderlineStyle(let underline):
            return (NSUnderlineStyleAttributeName, underline.rawValue)
        case .StrokeColor(let color):
            return (NSStrokeColorAttributeName, color)
        case .StrokeWidth(let width):
            return (NSStrokeWidthAttributeName, width)
        case .Shadow(let shadow):
            return (NSShadowAttributeName, shadow)
        case .TextEffect(let effect):
            return (NSTextEffectAttributeName, effect.attributedAttributeName)
        case .Attachment(let attachment):
            return (NSAttachmentAttributeName, attachment)
        case .Link(let link):
            return (NSLinkAttributeName, link)
        case .LinkAsString(let link):
            return (NSLinkAttributeName, link)
        case .BaseLineOffset(let offset):
            return (NSBaselineOffsetAttributeName, offset)
        case .UnderlineColor(let color):
            return (NSUnderlineColorAttributeName, color)
        case .StrikethroughColor(let color):
            return (NSStrikethroughColorAttributeName, color)
        case .Obliqueness(let obliqueness):
            return (NSObliquenessAttributeName, obliqueness)
        case .Expansion(let expansion):
            return (NSExpansionAttributeName, expansion)
        case .WritingDirection(let directions):
            return (NSWritingDirectionAttributeName, directions.map{ $0.rawValue })
        case .VerticalGlyphForm(let glyphForm):
            return (NSVerticalGlyphFormAttributeName, glyphForm.rawValue)
        }
    }
}

public class NSAttributedStringAttributeBuilder {
    
    private var attributesDictionary: [NSObject : AnyObject] = [ : ]
    
    public init() { }
    
    public func setAttribute(attribute: NSAttributedStringAttribute) {
        let keyValuePair = attribute.attributedStringKeyValuePair
        attributesDictionary.updateValue(keyValuePair.value, forKey: keyValuePair.key)
    }
    
    public func attributedStringAttributesDictionary() -> [NSObject: AnyObject] {
        return attributesDictionary
    }
}

public extension NSAttributedString {
    
    public class func make(string: String, make: ((make: NSAttributedStringAttributeBuilder) -> Void)) -> NSAttributedString {
        let builder = NSAttributedStringAttributeBuilder()
        make(make: builder)
        return NSAttributedString(string: string, attributes: builder.attributedStringAttributesDictionary())
    }
}
