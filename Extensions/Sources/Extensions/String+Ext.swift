//
//  String+Ext.swift
//  
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import UIKit

public extension String {
    func turkishToEnglishTransformed() -> String {
        let string = NSMutableString(string: self) as CFMutableString
        CFStringTransform(string, nil, kCFStringTransformToLatin, false)
        CFStringTransform(string, nil, kCFStringTransformStripDiacritics, false)
        let transformedString = string as String
        let replacedString = transformedString.replacingOccurrences(of: "ı", with: "i")
        let filteredString = replacedString.replacingOccurrences(of: " ", with: "+")
        return filteredString
    }
    
}
