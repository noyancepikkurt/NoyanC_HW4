//
//  NetworkService.swift
//  
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import Foundation

public protocol NetworkServiceProtocol: AnyObject {
    func fetchSong(pathUrl: String, completion: @escaping (Result<SongModel, Error>) -> Void)
}

final public class NetworkService: NetworkServiceProtocol {
    static public let shared = NetworkService()
    
    public func fetchSong(pathUrl: String, completion: @escaping (Result<SongModel, Error>) -> Void) {
        NetworkManager.shared.request(pathUrl: pathUrl) { (result: Result<SongModel, Error>) in
            switch result {
            case .success(let songModel):
                completion(.success(songModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
