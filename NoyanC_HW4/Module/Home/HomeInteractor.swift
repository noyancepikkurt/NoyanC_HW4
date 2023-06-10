//
//  HomeInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import Foundation
import SongAPI

typealias SongsSourceResult = Result<SongModel, Error>

protocol HomeInteractorProtocol: AnyObject {
    func fetchSongs()
}

protocol HomeInteractorOutputProtocol {
    func fetchSongsOutput(_ result: SongsSourceResult )
}

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    func fetchSongs() {
        NetworkService.shared.fetchSong(pathUrl: "https://itunes.apple.com/search?term=rihanna&country=tr&entity=song&attribute=mixTerm") { [weak self] result in
            guard let self else { return }
            self.output?.fetchSongsOutput(result)
        }
    }
}
