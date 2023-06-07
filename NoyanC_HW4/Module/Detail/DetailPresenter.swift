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
    func tapSeeMore() //
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
        view.setTitle("Detail")
        view.setSongTitle(song.trackName ?? "")
        view.setSongArtistName(song.artistName ?? "")
        view.setSongAlbumName(song.collectionName ?? "")
        
        ImageDownloader.shared.image(songs: song) { data, error in
            guard let data  = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            self.view.setSongImage(image)
        }
    }
    
    func tapSeeMore() {
        //test
    }
}
