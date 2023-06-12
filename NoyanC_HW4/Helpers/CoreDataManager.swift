//
//  CoreDataManager.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import UIKit
import CoreData
import SongAPI

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    func isSongDetailFavorite(_ model: SongDetail) -> Bool {
        let favorites = fetchFavorites()
        let favorite = favorites.first { $0.trackID == String(describing: model.trackID) }
        return favorite != nil
    }
    
    private func fetchFavorites() -> [SongEntity] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }
    
    func fetchSongs(completion: @escaping (Result<[SongEntity], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<SongEntity>
        request = SongEntity.fetchRequest()
        
        do {
            try context.save()
            let songs = try context.fetch(request)
            completion(.success(songs))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteAllData(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(.failure(NSError(domain: "AppDelegate Not Found", code: 0, userInfo: nil)))
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SongEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveOrDelete(_ model: SongDetail) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trackID == %@", String(describing: model.trackID))
        
        do {
            let results = try context.fetch(fetchRequest)
            if let songEntity = results.first {
                context.delete(songEntity)
                try context.save()
            } else {
                guard let songEntity = convertToSongEntity(model: model) else { return }
                songEntity.isFavorite = true
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func deleteSongEntity(withTrackID trackID: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trackID == %@", trackID)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let songEntity = results.first {
                context.delete(songEntity)
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func convertToSongEntity(model: SongDetail) -> SongEntity? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        guard let trackPrice = model.trackPrice else { return nil }
        guard let collectionPrice = model.collectionPrice else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        let songEntity = SongEntity(context: context)
        songEntity.trackPrice = trackPrice
        songEntity.collectionPrice = collectionPrice
        songEntity.songName = model.trackName
        songEntity.songKind = model.kind
        songEntity.artistName = model.artistName
        songEntity.albumName = model.collectionName
        songEntity.isFavorite = true
        songEntity.artworkUrl = model.artworkUrl100
        songEntity.trackID = String(describing: model.trackID)
        return songEntity
    }
}
