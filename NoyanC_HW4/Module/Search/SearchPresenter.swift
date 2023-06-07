//
//  SearchPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import Foundation
import SongAPI

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func songs(_ index: Int) -> SongDetail?
    func didSelectRowAt(index: Int)
    func fetchSongsFilter(with word: String)
}

final class SearchPresenter {
    weak var view: SearchViewControllerProtocol?
    let router: SearchRouterProtocol!
    let interactor: SearchInteractorProtocol!
    
    private var songDetail: [SongDetail] = []
    
    init(view: SearchViewControllerProtocol,
         router: SearchRouterProtocol,
         interactor: SearchInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchPresenterProtocol {
   
    func viewDidLoad() {
        view?.setupTableView()
        view?.setTitle("Songs")
    }
    
    func numberOfItems() -> Int {
        songDetail.count
    }
    
    func songs(_ index: Int) -> SongDetail? {
        return songDetail[index]
    }
    
    func didSelectRowAt(index: Int) {
        let selectedSong = songs(index)
        router.navigate(.detail(source: selectedSong))
    }
    
    func fetchSongsFilter(with word: String) {
        view?.showLoadingView()
        interactor.fetchSongs(word)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func fetchSongsOutput(_ result: SongsSourcesResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let response):
            self.songDetail = response.results!
            view?.reloadData()
        case .failure(let error):
//            view?.showError("There is no")
            print(error.localizedDescription)
        }
    }
}


