//
//  NetworkConstants.swift
//  
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import Foundation

public enum NetworkURL: String {
    
    case songSearchURL = "https://itunes.apple.com/search?term="
//    case populerURL = "https://itunes.apple.com/search?term="
    
    public func createSearchURL(for englishWord: String) -> String {
        let urlString = self.rawValue + englishWord + "&country=tr&entity=song&attribute=mixTerm"
        return urlString
    }
    
    public func populerURL(for popular: String) -> String {
        let urlString = self.rawValue + popular + "&country=tr&entity=song&attribute=mixTerm"
        return urlString
    }

}
