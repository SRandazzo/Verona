//
//  Verona.swift
//  Verona
//
//  Created by Salvatore Randazzo on 6/3/15.
//  Copyright (c) 2015 Salvatore Randazzo. All rights reserved.
//

import Foundation

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
    case textEffect(NSAttributedString.TextEffectStyle)
    case attachment(NSTextAttachment)
    case link(URL)
    case linkAsString(String)
    case baseLineOffset(CGFloat)
    case obliqueness(CGFloat)
    case expansion(CGFloat)
    case writingDirection([NSTextWritingDirection])
    case verticalGlyphForm(VerticalGlyphFormDirection) //1 vertical, 0 horiztonal
    
    public var attributedStringKeyValuePair: (key: NSAttributedString.Key, value: Any) {
        switch self {
        case .font(let font):
            return (NSAttributedString.Key.font, font)
        case .paragraphStyle(let style):
            return (NSAttributedString.Key.paragraphStyle, style)
        case .color(let color):
            return (NSAttributedString.Key.foregroundColor, color)
        case .backgroundColor(let color):
            return (NSAttributedString.Key.backgroundColor, color)
        case .ligature(let ligature):
            return (NSAttributedString.Key.ligature, ligature ? 1 : 0)
        case .kerning(let kerning):
            return (NSAttributedString.Key.kern, kerning as AnyObject)
        case .strikethrough(let strikethrough):
            return (NSAttributedString.Key.strikethroughStyle, strikethrough.rawValue as AnyObject)
        case .underlineStyle(let underline):
            return (NSAttributedString.Key.underlineStyle, underline.rawValue as AnyObject)
        case .strokeColor(let color):
            return (NSAttributedString.Key.strokeColor, color)
        case .strokeWidth(let width):
            return (NSAttributedString.Key.strokeWidth, width as AnyObject)
        case .shadow(let shadow):
            return (NSAttributedString.Key.shadow, shadow)
        case .textEffect(let effect):
            return (NSAttributedString.Key.textEffect, effect as AnyObject)
        case .attachment(let attachment):
            return (NSAttributedString.Key.attachment, attachment)
        case .link(let link):
            return (NSAttributedString.Key.link, link as AnyObject)
        case .linkAsString(let link):
            return (NSAttributedString.Key.link, link as AnyObject)
        case .baseLineOffset(let offset):
            return (NSAttributedString.Key.baselineOffset, offset as AnyObject)
        case .underlineColor(let color):
            return (NSAttributedString.Key.underlineColor, color)
        case .strikethroughColor(let color):
            return (NSAttributedString.Key.strikethroughColor, color)
        case .obliqueness(let obliqueness):
            return (NSAttributedString.Key.obliqueness, obliqueness as AnyObject)
        case .expansion(let expansion):
            return (NSAttributedString.Key.expansion, expansion as AnyObject)
        case .writingDirection(let directions):
            return (NSAttributedString.Key.writingDirection, directions.map{ $0.rawValue })
        case .verticalGlyphForm(let glyphForm):
            return (NSAttributedString.Key.verticalGlyphForm, glyphForm.rawValue as AnyObject)
        }
    }
}

open class NSAttributedStringAttributeBuilder {
    
    fileprivate var attributesDictionary: [NSAttributedString.Key : Any] = [ : ]
    
    public init() { }
    
    open func setAttribute(_ attribute: NSAttributedStringAttribute) {
        let keyValuePair = attribute.attributedStringKeyValuePair
        attributesDictionary.updateValue(keyValuePair.value, forKey: keyValuePair.key)
    }
    
    open func attributedStringAttributesDictionary() -> [NSAttributedString.Key: Any]? {
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
