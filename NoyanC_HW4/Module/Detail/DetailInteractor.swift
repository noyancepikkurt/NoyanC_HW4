//
//  DetailInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import Foundation
import SongAPI


// coredata?
protocol DetailInteractorProtocol {
    
}

protocol DetailInteractorOutputProtocol {
    func fetchSongsDetailOutput(result:SongsSourcesResult )
}

final class DetailInteractor {
    var output: SearchInteractorOutputProtocol?
}
