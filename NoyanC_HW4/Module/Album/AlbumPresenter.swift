//
//  AlbumPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import Foundation
import SongAPI

protocol AlbumPresenterProtocol {
    func viewDidLoad()
    func numberOfItem() -> Int
    func albumSongs(_ index: Int) -> SongDetail
    func didSelectRowAt(index: Int)
    func getSource() -> SongDetail?
    var source: SongDetail? { get set }
}

final class AlbumPresenter {
    
    weak var view: AlbumViewControllerProtocol?
    let router: AlbumRouterProtocol!
    let interactor: AlbumInteractorProtocol!
    
    var albumSongs = [SongDetail]()
    var source: SongDetail?
    
    init(view: AlbumViewControllerProtocol,
         router: AlbumRouterProtocol,
         interactor: AlbumInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension AlbumPresenter: AlbumPresenterProtocol {
    
    func getSource() -> SongDetail? {
        return source
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        fetchAlbumSongs()
    }
    
    func numberOfItem() -> Int {
        return albumSongs.count
    }
    
    func albumSongs(_ index: Int) -> SongDetail {
        return albumSongs[index]
    }
    
    func didSelectRowAt(index: Int) {
        let selectedSong = albumSongs(index)
        router.navigate(.detail(source: selectedSong))
    }
    
    private func fetchAlbumSongs() {
        //        view?.showLoading()
        interactor.fetchAlbumSongs()
    }
}

extension AlbumPresenter: AlbumInteractorOutputProtocol {
    func fetchAlbumSongsOutput(_ result: AlbumSongsResult) {
        switch result {
        case .success(let success):
            guard let result = success.results else { return }
            self.albumSongs = result
            view?.reloadData()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
