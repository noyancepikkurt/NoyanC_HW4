//
//  AlbumCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 11.06.2023.
//

import SongAPI
import SDWebImage

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
        view.setSongName(songDetail.trackName ?? "")
        view.setArtistName(songDetail.artistName ?? "")
        
        view.showIndicator()
        guard let imageUrl = songDetail.artworkUrl100 else { return }
        let qualityImageUrl = ImageUrlTransform.shared.improveQuality(imageUrl)
        SDWebImageManager.shared.loadImage(with: URL(string: qualityImageUrl), context: nil, progress: nil) { image, _, error, _, _, _ in
            if let image {
                self.view.setImage(image)
                self.view.hideIndicator()
            }
        }
    }
}
