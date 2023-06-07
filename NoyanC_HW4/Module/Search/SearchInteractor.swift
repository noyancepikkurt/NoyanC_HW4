//
//  SearchInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import Foundation
import SongAPI
import Extensions

typealias SongsSourcesResult = Result<SongModel, Error>

protocol SearchInteractorProtocol: AnyObject {
    func fetchSongs(_ word: String)
}

protocol SearchInteractorOutputProtocol {
    func fetchSongsOutput(_ result: SongsSourcesResult)
}

final class SearchInteractor {
    var output: SearchInteractorOutputProtocol?
}

extension SearchInteractor: SearchInteractorProtocol {
    func fetchSongs(_ word: String) {
        let filterWord = word.replacingOccurrences(of: " ", with: "+")
        let englishWord = filterWord.turkishToEnglishTransformed()
        NetworkService.shared.fetchSong(pathUrl: "https://itunes.apple.com/search?term=\(englishWord)&country=tr&entity=song&attribute=mixTerm") { result in
            self.output?.fetchSongsOutput(result)
        }
    }
}


