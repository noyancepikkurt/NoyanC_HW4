//
//  ImageDownload.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//


import UIKit
import CoreData
import SongAPI

enum ImageDownloadError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}

public class ImageDownload {
    public static var shared = ImageDownload()
    private var images = NSCache<NSString, NSData>()
    
    let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        if let imageData = images.object(forKey: imageURL.absoluteString as NSString) {
            completion(imageData as Data, nil)
            return
        }
        
        let task = session.downloadTask(with: imageURL) { localUrl, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, ImageDownloadError.badResponse(response))
                return
            }
            
            guard let localUrl = localUrl else {
                completion(nil, ImageDownloadError.badLocalUrl)
                return
            }
            
            do {
                let data = try Data(contentsOf: localUrl)
                self.images.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    public func image(songs: SongDetail, completion: @escaping (Data?, Error?) -> (Void)) {
        if let image = songs.artworkUrl100 {
            guard let url = URL(string: image) else { return }
            download(imageURL: url, completion: completion)
        }
    }
    
    public func imageCoreData(songs: SongEntity, completion: @escaping (Data?, Error?) -> (Void)) {
        if let image = songs.artworkUrl {
            guard let url = URL(string: image) else { return }
            print(url)
            download(imageURL: url, completion: completion)
        }
    }
}
