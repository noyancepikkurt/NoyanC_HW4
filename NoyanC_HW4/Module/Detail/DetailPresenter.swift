//
//  DetailPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit
import SongAPI
import CoreData

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func likeButtonClicked()
}

final class DetailPresenter {
    unowned var view: DetailViewControllerProtocol!
    let router: DetailRouterProtocol!
    var interactor: DetailInteractorProtocol!
    var coreDataModel = [SongEntity]()
    var songDetail: SongDetail?
    
    init(view: DetailViewControllerProtocol,
         router: DetailRouterProtocol,
         interactor: DetailInteractorProtocol!) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func likeButtonClicked() {
        guard let songDetail else { return }
        interactor.save(songDetail)
        interactor.fetch()
    }
    
    func viewDidLoad() {
        songDetail = view.getSource()
        guard let songDetail else { return }
        guard let trackPrice = songDetail.trackPrice else { return }
        guard let collectionPrice = songDetail.collectionPrice else { return }
        view.setSongTitle(songDetail.trackName ?? "")
        view.setSongArtistName(songDetail.artistName ?? "")
        view.setSongKindName(songDetail.primaryGenreName ?? "")
        view.setSongTrackPrice("Track Price: \(String(describing: trackPrice)) TRY")
        view.setSongCollectionPrice("Collection Price: \(String(describing: collectionPrice)) TRY")
        
        ImageDownload.shared.image(songs: songDetail) { data, error in
            guard let data  = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            self.view.setSongImage(image)
        }
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func saveCoreData(_ saveResult: SongEntity) {
        self.coreDataModel.append(saveResult)
    }
    
    func fetchCoreData(_ fetchResult: CoreDataResult) {
        switch fetchResult {
        case .success(let response):
            self.coreDataModel = response
            print("coredata count = \(coreDataModel.count)")
        case .failure(_):
            break
        }
    }
}

