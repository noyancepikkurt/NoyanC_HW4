//
//  PopularCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import SongAPI

protocol RecentlySearchCellPresenterProtocol: AnyObject {
    func load()
}

final class RecentlySearchPresenter {
    weak var view: RecentlySearchCellProtocol?
    private let songDetail: SongDetail
    
    init(view: RecentlySearchCellProtocol,
         songDetail: SongDetail) {
        self.view = view
        self.songDetail = songDetail
    }
}

extension RecentlySearchPresenter: RecentlySearchCellPresenterProtocol {
    func load() {
        view?.setImage(songDetail.artworkUrl100 ?? "")
        view?.setSongName(songDetail.trackName ?? "")
        view?.setArtistName(songDetail.artistName ?? "")
    }
}
