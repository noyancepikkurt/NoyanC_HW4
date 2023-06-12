//
//  HomePresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import UIKit // -> UIImage(for entity model)
import SongAPI

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func songs(_ index: Int) -> SongDetail?
    func didSelectRowAt(index: Int)
    func didSelectRowAtAlbums(index: Int)
    var featuredModel: [FeaturedEntity]? { get set }
}

final class HomePresenter {
    unowned var view: HomeViewControllerProtocol?
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    var featuredModel: [FeaturedEntity]?
    
    private var songDetail: [SongDetail] = []
    
    init(view: HomeViewControllerProtocol,
         router: HomeRouterProtocol,
         interactor: HomeInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    private func featuredModelConfig() {
        featuredModel = [FeaturedEntity(albumName: AlbumNames.pinhani.rawValue, image: UIImage(named: Icons.pinhani.rawValue)!),
                         FeaturedEntity(albumName: AlbumNames.ezhel.rawValue, image: UIImage(named: Icons.ezhel.rawValue)!),
                         FeaturedEntity(albumName: AlbumNames.sezenAksu.rawValue, image: UIImage(named: Icons.sezenAksu.rawValue)!),
                         FeaturedEntity(albumName: AlbumNames.mfo.rawValue, image: UIImage(named: Icons.mfo.rawValue)!)]
    }
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        featuredModelConfig()
        view?.registerCollectionViews()
        fetchSongs()
    }
    
    func numberOfItems() -> Int {
        return self.songDetail.count
    }
    
    func songs(_ index: Int) -> SongDetail? {
        return songDetail[index]
    }
    
    func didSelectRowAt(index: Int) {
        let selectedSong = songs(index)
        router.navigate(.detail(source: selectedSong))
    }
    
    func didSelectRowAtAlbums(index: Int) {
        router.navigate(.album)
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
            print(error.localizedDescription)
        }
    }
}

