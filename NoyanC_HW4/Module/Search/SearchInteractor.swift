//
//  SearchInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import Foundation
import SongAPI

typealias SongsSourcesResult = Result<SongModel, Error>

protocol SearchInteractorProtocol: AnyObject {
    func fetchSongs()
}

protocol SearchInteractorOutputProtocol {
    func fetchSongsOutput(_ result: SongsSourcesResult)
}

fileprivate var songService: NetworkServiceProtocol?

final class SearchInteractor {
    var output: SearchInteractorOutputProtocol?
}

extension SearchInteractor: SearchInteractorProtocol {
    
    func fetchSongs() {
        songService?.fetchSong(pathUrl: "https://itunes.apple.com/search?term=tarkan&country=tr&entity=song&attribute=mixTerm", completion: { result in
            self.output?.fetchSongsOutput(result)
        })
    }
    
    
}


