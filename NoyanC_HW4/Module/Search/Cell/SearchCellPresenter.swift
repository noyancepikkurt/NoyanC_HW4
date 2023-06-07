//
//  SearchCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit
import SongAPI

protocol SearchCellPresenterProtocol: AnyObject {
    func load()
}

final class SearchCellPresenter {
    weak var view: SearchCellProtocol?
    private let song: SongDetail
    
    init(view: SearchCellProtocol,
         song: SongDetail) {
        self.view = view
        self.song = song
    }
}

extension SearchCellPresenter: SearchCellPresenterProtocol {
    func load() {
        ImageDownloader.shared.image(songs: song) { data, error in
            if let data {
                guard let image = UIImage(data: data) else { return }
                self.view?.setImage(image)
            }
        }
        view?.setSongName(song.trackName ?? "")
        view?.setAlbumName(song.collectionName ?? "")
        view?.setArtistName(song.artistName ?? "")
    }
}
