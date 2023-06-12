//
//  AlbumCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 11.06.2023.
//

import SongAPI

protocol AlbumCellPresenterProtocol: AnyObject {
    func load()
}

final class AlbumCellPresenter {
    unowned var view: AlbumTableViewCellProtocol
    private let songDetail: SongDetail
    
    init(view: AlbumTableViewCellProtocol,
         songDetail: SongDetail
    ) {
        self.view = view
        self.songDetail = songDetail
    }
}

extension AlbumCellPresenter: AlbumCellPresenterProtocol {
    func load() {
        view.setImage(songDetail.artworkUrl100 ?? "")
        view.setSongName(songDetail.trackName ?? "")
        view.setArtistName(songDetail.artistName ?? "")
    }
}
