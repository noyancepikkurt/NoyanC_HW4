//
//  FavoritesCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import CoreData
import SDWebImage

protocol FavoritesCellPresenterProtocol: AnyObject {
    func load()
}

final class FavoritesCellPresenter {
    weak var view: FavoritesCellProtocol?
    private let songs: SongEntity
    
    init(view: FavoritesCellProtocol,
         songs: SongEntity) {
        self.view = view
        self.songs = songs
    }
}

extension FavoritesCellPresenter: FavoritesCellPresenterProtocol {
    func load() {
        view?.setSongName(songs.songName ?? "")
        view?.setArtist(songs.artistName ?? "")
        view?.setAlbum(songs.albumName ?? "")
        
        guard let imageUrl = songs.artworkUrl else { return }
        let qualityImageUrl = ImageUrlTransform.shared.improveQuality(imageUrl)
        SDWebImageManager.shared.loadImage(with: URL(string: qualityImageUrl), context: nil, progress: nil) { image, _, error, _, _, _ in
            if let image {
                self.view?.setImage(image)
            }
        }
    }
}
