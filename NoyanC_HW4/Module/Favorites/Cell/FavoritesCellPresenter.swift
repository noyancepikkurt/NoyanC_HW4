//
//  FavoritesCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

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
        view?.setImage(songs.artworkUrl ?? "")
        view?.setSongName(songs.songName ?? "")
        view?.setArtist(songs.artistName ?? "")
        view?.setAlbum(songs.albumName ?? "")
    }
}
