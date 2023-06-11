//
//  NetworkConstants.swift
//  
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import Foundation

public enum NetworkURL: String {
    
    case songSearchURL = "https://itunes.apple.com/search?term="
    
//    public func createSearchURL(for englishWord: String) -> String {
//        let urlString = self.rawValue + englishWord + "&country=tr&entity=musicTrack&attribute=mixTerm"
//        return urlString
//    }
    
    public func createURL(for albumName: String) -> String {
        let urlString = self.rawValue + albumName + "&country=tr&entity=musicTrack&attributes=mixTerm"
        return urlString
    }
}
