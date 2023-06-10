//
//  PopularCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import UIKit
import SongAPI

protocol PopularCellPresenterProtocol: AnyObject {
    func load()
}

final class PopularCellPresenter {
    weak var view: PopularCellProtocol?
    private let songDetail: SongDetail
    
    init(view: PopularCellProtocol,
         songDetail: SongDetail) {
        self.view = view
        self.songDetail = songDetail
    }
}

extension PopularCellPresenter: PopularCellPresenterProtocol {
    func load() {
        ImageDownload.shared.image(songs: songDetail) { data, error in
            if let data {
                guard let img = UIImage(data: data) else { return }
                self.view?.setImage(img)
            }
        }
        view?.setSongName(songDetail.trackName ?? "")
        view?.setArtistName(songDetail.artistName ?? "")
    }
}
