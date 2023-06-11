//
//  FavoritesCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import UIKit // UIImage
import CoreData

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
        ImageDownload.shared.imageCoreData(songs: songs) { data, error in
            if let data {
                guard let img = UIImage(data:data) else { return }
                self.view?.setImage(img)
            }
        }
        view?.setSongName(songs.songName ?? "")
        view?.setArtist(songs.artistName ?? "")
        view?.setAlbum(songs.albumName ?? "")
    }
}
