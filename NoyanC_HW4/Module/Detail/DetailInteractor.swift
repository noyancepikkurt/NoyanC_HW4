//
//  DetailInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit
import SongAPI
import CoreData

protocol DetailInteractorProtocol {
    func saveOrDelete(_ model: SongDetail)
}

final class DetailInteractor {
    var coreDataModel: SongEntity?
}

extension DetailInteractor: DetailInteractorProtocol {
    
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
    
    private func convertToSongEntity(model: SongDetail) -> SongEntity? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        guard let trackPrice = model.trackPrice else { return SongEntity()}
        guard let collectionPrice = model.collectionPrice else { return SongEntity()}
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
