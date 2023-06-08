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
    
    func saveNew(model: SongDetail, isFavorite: Bool, completion: @escaping ((Result<Void, Error>)->Void)) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let item = SongEntity(context: context)
        item.trackPrice = model.trackPrice!
        item.collectionPrice = model.collectionPrice!
        item.songName = model.trackName
        item.songKind = model.kind
        item.artistName = model.artistName
        item.albumName = model.collectionName
        item.isFavorite = isFavorite
        item.artworkUrl = model.artworkUrl100
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            print(completion(.failure(error)))
        }
    }
    
    func fetchNew(completion: @escaping (Result<[SongEntity], Error>) -> Void) {
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
    
    func deleteNew(model: SongEntity, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
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
