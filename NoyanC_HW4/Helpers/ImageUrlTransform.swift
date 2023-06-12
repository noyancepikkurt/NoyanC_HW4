//
//  ImageUrlTransform.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 12.06.2023.
//

import Foundation

final class ImageUrlTransform {
    static let shared = ImageUrlTransform()
    
    func improveQuality(_ urlString: String) -> String  {
        let updatedURL = urlString.replacingOccurrences(of: "100x100bb.jpg", with: "500x500.jpg")
        return updatedURL
    }
}
