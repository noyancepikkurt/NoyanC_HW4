//
//  SearchInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import SongAPI
import Extensions

typealias SongsSourcesResult = Result<SongModel, Error>

protocol SearchInteractorProtocol: AnyObject {
    func fetchSongs(_ word: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func fetchSongsOutput(_ result: SongsSourcesResult)
}

final class SearchInteractor {
    var output: SearchInteractorOutputProtocol?
}

extension SearchInteractor: SearchInteractorProtocol {
    func fetchSongs(_ word: String) {
        let englishWord = word.turkishToEnglishTransformed()
        NetworkService.shared.fetchSong(pathUrl: NetworkURL.songSearchURL.createURL(for: englishWord)) { result in
            self.output?.fetchSongsOutput(result)
        }
    }
}


