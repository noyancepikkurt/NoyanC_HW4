//
//  AlbumInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import Foundation

protocol AlbumInteractorProtocol {
    
}

protocol AlbumInteractorOutputProtocol {
    
}

final class AlbumInteractor {
    var output: AlbumInteractorOutputProtocol?
}

extension AlbumInteractor: AlbumInteractorProtocol {
    
}

extension AlbumInteractor: AlbumInteractorOutputProtocol {
    
}
