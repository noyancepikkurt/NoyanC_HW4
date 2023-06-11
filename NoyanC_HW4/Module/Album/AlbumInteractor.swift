//
//  AlbumInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import Foundation
import SongAPI

typealias AlbumSongsResult = Result<SongModel, Error>

protocol AlbumInteractorProtocol {
    func fetchAlbumSongs()
}

protocol AlbumInteractorOutputProtocol {
    func fetchAlbumSongsOutput(_ result: AlbumSongsResult)
}

final class AlbumInteractor {
    var output: AlbumInteractorOutputProtocol?
}

extension AlbumInteractor: AlbumInteractorProtocol {
    func fetchAlbumSongs() {
        guard let albumName = FeaturedEntity.albumName else { return }
        let englishAlbumName = albumName.turkishToEnglishTransformed()
        NetworkService.shared.fetchSong(pathUrl: "https://itunes.apple.com/search?term=\(englishAlbumName)&country=tr&entity=song&attribute=albumTerm") { [weak self] result in
            guard let self else { return }
            self.output?.fetchAlbumSongsOutput(result)
        }
    }                                        
}

extension AlbumInteractor: AlbumInteractorOutputProtocol {
    func fetchAlbumSongsOutput(_ result: AlbumSongsResult) {
        //
    }
    
    
}
