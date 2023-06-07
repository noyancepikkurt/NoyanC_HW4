//
//  String+Ext.swift
//  
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import UIKit

extension String {
    public func turkishToEnglishTransformed() -> String {
        let string = NSMutableString(string: self) as CFMutableString
        CFStringTransform(string, nil, kCFStringTransformToLatin, false)
        CFStringTransform(string, nil, kCFStringTransformStripDiacritics, false)
        return string as String
    }
}
