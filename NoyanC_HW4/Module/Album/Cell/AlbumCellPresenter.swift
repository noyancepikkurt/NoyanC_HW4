//
//  AlbumCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 11.06.2023.
//

import UIKit // UIImage
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
        ImageDownload.shared.image(songs: songDetail) { [weak self] data, error in
            guard let self else { return}
            if let data {
                guard let img = UIImage(data: data) else { return }
                self.view.setImage(img)
            }
        }
        view.setSongName(songDetail.trackName ?? "")
        view.setArtistName(songDetail.artistName ?? "")
    }
}
