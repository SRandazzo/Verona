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

public enum VeronaError: ErrorType {
    case StringNotSet(string: NSString)
}

public class NSAttributedStringAttributeBuilder {
    
    
    private var clearAttributesOnNextString: Bool = false
    
    private var currentString: String = ""
    private var strings = [String]()
    
    var currentAttributes: [String : AnyObject] = [ : ]
    var attributes = [[String: AnyObject]]()
    
    public init() { }
    
    public func setAttribute(attribute: NSAttributedStringAttribute) throws {
        let keyValuePair = attribute.attributedStringKeyValuePair
        currentAttributes.updateValue(keyValuePair.value, forKey: keyValuePair.key)
    }
    
    public func clearAttributes() {
        currentAttributes.removeAll()
    }
    
    public func addAttributes(attributes: [String: AnyObject]) {
        for (key, value) in attributes {
            currentAttributes.updateValue(value, forKey: key)
        }
    }
    
    public func removeAttribute(attribute: NSAttributedStringAttribute) throws {
        let keyValuePair = attribute.attributedStringKeyValuePair
        currentAttributes.removeValueForKey(keyValuePair.key)
    }
    
    public func removeAttributes(attributes: [String: AnyObject]) {
        for (key, _) in attributes {
            currentAttributes.removeValueForKey(key)
        }
    }
    
    public func nextString(string: String) {
        endCurrent()
        currentString = string
    }
    
    private func endCurrent() {
        attributes.append(currentAttributes)
        strings.append(currentString)
        if (clearAttributesOnNextString) {
            clearAttributes()
        }
        currentString = ""
    }
    
    func finalize() -> NSAttributedString {
        let attrStrings = zip(strings, attributes)
            .map { (str: String, attr: [String: AnyObject]) in
                return NSAttributedString(string: str, attributes: attr)
            }
        
        // TODO: Get reduce to work instead of whats below. Was showing ambiguous errors with mutable string as accumulator
        let mut = NSMutableAttributedString()
        for attr in attrStrings {
            mut.appendAttributedString(attr)
        }
        return mut
    }
}

public extension NSAttributedString {
    
    public class func make(string: String, make: ((make: NSAttributedStringAttributeBuilder) -> Void)) -> NSAttributedString {
        let builder = NSAttributedStringAttributeBuilder()
        builder.nextString(string)
        make(make: builder)
        return builder.finalize()
    }
    
    public class func make(make: ((make: NSAttributedStringAttributeBuilder) -> Void)) -> NSAttributedString {
        let builder = NSAttributedStringAttributeBuilder()
        let final = builder.finalize()
        return final
    }
}
