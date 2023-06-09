//
//  HomePresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import Foundation
import SongAPI

protocol HomePresenterProtocol {
    func viewDidLoad()
    func numberOfItems() -> Int
    func songs(_ index: Int) -> SongDetail?
    func didSelectRowAt(index: Int)
}

final class HomePresenter {
    unowned var view: HomeViewControllerProtocol?
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    private var songDetail: [SongDetail] = []
    
    init(view: HomeViewControllerProtocol,
         router: HomeRouterProtocol,
         interactor: HomeInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        view?.registerCollectionViews()
        fetchSongs()
    }
    
    func numberOfItems() -> Int {
        print("deneme\(self.songDetail.count)")
        return self.songDetail.count
    }
    
    func songs(_ index: Int) -> SongDetail? {
        return songDetail[index]
    }
    
    func didSelectRowAt(index: Int) {
        let selectedSong = songs(index)
        router.navigate(.detail(source: selectedSong))
    }
    
    private func fetchSongs() {
        view?.showLoadingView()
        interactor.fetchSongs()
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func fetchSongsOutput(_ result: SongsSourceResult) {
        view?.hideLoadingView()
        
        switch result {
        case .success(let response):
            guard let songDetail = response.results else { return }
            self.songDetail = songDetail
            view?.reloadData()
            
        case .failure(let error):
            //show alert?
            print(error.localizedDescription)
        }
    }
}
