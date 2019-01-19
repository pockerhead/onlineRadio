//
//  Extension+String.swift
//  DealApp
//
//  Created by Egor Sakhabaev on 06.05.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
import UIKit
//extension String {
//    var md5: String {
//        return MD5(self)
//    }
//    
//    func fromBase64() -> String? {
//        guard let data = Data(base64Encoded: self) else {
//            return nil
//        }
//        
//        return String(data: data, encoding: .utf8)
//    }
//    
//    func toBase64() -> String {
//        return Data(self.utf8).base64EncodedString()
//    }
//    
//}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
    
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
    {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return NSAttributedString(attributedString: result)
    }
}

extension CharacterSet {
    static let rfc3986Unreserved = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")
}

extension String {
    func removingRegexMatches(pattern: String, replaceWith: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange.init(location: 0, length: self.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return self
        }
    }
    
}

extension String {
    var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attrText = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
//            if !self.contains("<font") {
//                attrText.addAttribute(.font, value: UIFont.systemFont(ofSize: 19), range: NSMakeRange(0, attrText.length))
//            }
            return attrText
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? self
    }
    
    func htmlToString(font: UIFont = .systemFont(ofSize: 16, weight: .regular), color: UIColor = .black) -> NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attrText = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            attrText.addAttributes([.font: font, .foregroundColor: color], range: NSMakeRange(0, attrText.length))
            return attrText
        } catch {
            return nil
        }
    }
    
}
