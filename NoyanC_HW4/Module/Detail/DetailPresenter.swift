//
//  DetailPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit
import SongAPI

protocol DetailPresenterProtocol {
    func viewDidLoad()
}

final class DetailPresenter {
    unowned var view: DetailViewControllerProtocol!
    let router: DetailRouterProtocol!
    
    init(view: DetailViewControllerProtocol,
         router: DetailRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        guard let song = view.getSource() else { return }
        guard let trackPrice = song.trackPrice else { return }
        guard let collectionPrice = song.collectionPrice else { return }
        view.setTitle("Detail")
        view.setSongTitle(song.trackName ?? "")
        view.setSongArtistName(song.artistName ?? "")
        view.setSongKindName(song.primaryGenreName ?? "")
        view.setSongTrackPrice("Track Price: \(String(describing: trackPrice)) TRY")
        view.setSongCollectionPrice("Collection Price: \(String(describing: collectionPrice)) TRY")
        
        ImageDownloader.shared.image(songs: song) { data, error in
            guard let data  = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            self.view.setSongImage(image)
        }
    }
    
}
