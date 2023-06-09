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
            // Core Data'da favori olarak işaretlenmiş olan SongEntity'leri al
            let favorites = fetchFavorites()
            
            // Verilen SongDetail modelinin trackName değerine sahip olanı ara
            let favorite = favorites.first { $0.songName == model.trackName }
            
            // Eğer favori varsa true, yoksa false döndür
            return favorite != nil
        }
        
        private func fetchFavorites() -> [SongEntity] {
            // Favori olarak işaretlenmiş olan SongEntity'leri fetch et
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
}
