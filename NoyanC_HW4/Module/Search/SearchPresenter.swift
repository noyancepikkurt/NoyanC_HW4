//
//  SearchPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import Foundation
import SongAPI

protocol SearchPresenterProtocol {
    func viewDidLoad()
    func numberOfItems() -> Int
    func songs(_ index: Int) -> SongDetail?
    func didSelectRowAt(index: Int)
}

final class SearchPresenter {
   
    var view: SearchViewControllerProtocol
    let router: SearchRouterProtocol!
    let interactor: SearchInteractorProtocol!
    
    private var songs: [SongDetail]?
    
    init(
         view: SearchViewControllerProtocol,
         router: SearchRouterProtocol,
         interactor: SearchInteractorProtocol)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func viewDidLoad() {
        view.setupTableView()
        view.setTitle("Songs")
        fetchNews()
    }
    
    func numberOfItems() -> Int {
        guard let songs = songs else { return 0 }
        return songs.count
    }
    
    func songs(_ index: Int) -> SongDetail? {
        return songs?[index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let source = songs(index) else { return }
        router.navigate(.detail(source: source))
    }
    
    private func fetchNews() {
        interactor.fetchSongs()
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
    func fetchSongsOutput(_ result: SongsSourcesResult) {
        
        switch result {
        case .success(let response):
            self.songs = response.results
            view.reloadData()
        case .failure(let error):
            view.showError(error.localizedDescription)
        }
        
    }
    
}


