//
//  SongModel.swift
//  
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import Foundation

// MARK: - SongModel
public struct SongModel: Codable {
    public let resultCount: Int?
    public let results: [SongDetail]?
}

// MARK: - Result
public struct SongDetail: Codable {
    public let wrapperType: String?
    public let kind: String?
    public let artistID, collectionID, trackID: Int?
    public let artistName, collectionName, trackName, collectionCensoredName: String?
    public let trackCensoredName: String?
    public let artistViewURL, collectionViewURL, trackViewURL: String?
    public let previewURL: String?
    public let artworkUrl30, artworkUrl60, artworkUrl100: String?
    public let collectionPrice, trackPrice: Double?
    public let releaseDate: String?
    public let collectionExplicitness, trackExplicitness: String?
    public let discCount, discNumber, trackCount, trackNumber: Int?
    public let trackTimeMillis: Int?
    public let country: String?
    public let currency: String?
    public let primaryGenreName: String?
    public let isStreamable: Bool?
    public let contentAdvisoryRating: String?
    public let collectionArtistID: Int?
    public let collectionArtistName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, contentAdvisoryRating
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName
    }
}

public enum Explicitness: String, Codable {
    case explicit = "explicit"
    case notExplicit = "notExplicit"
}

public enum Country: String, Codable {
    case tur = "TUR"
}

public enum Currency: String, Codable {
    case currencyTRY = "TRY"
}

public enum Kind: String, Codable {
    case song = "song"
}

public enum WrapperType: String, Codable {
    case track = "track"
}
