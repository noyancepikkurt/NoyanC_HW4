//
//  PopularCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import SongAPI
import SDWebImage

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
        view?.setSongName(songDetail.trackName ?? "")
        view?.setArtistName(songDetail.artistName ?? "")
        
        view?.showIndicator()
        guard let imageUrl = songDetail.artworkUrl100 else { return }
        let qualityImageUrl = ImageUrlTransform.shared.improveQuality(imageUrl)
        SDWebImageManager.shared.loadImage(with: URL(string: qualityImageUrl), context: nil, progress: nil) { [weak self] image, _, error, _, _, _ in
            guard let self else { return }
            if let image {
                self.view?.setImage(image)
                self.view?.hideIndicator()
            }
        }
    }
}
