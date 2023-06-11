//
//  AlbumTableViewCell.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import UIKit

protocol AlbumTableViewCellProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setSongName(_ text: String)
    func setArtistName(_ text: String)
}

final class AlbumTableViewCell: UITableViewCell {
    @IBOutlet private weak var songImageView: UIImageView!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    
    var cellPresenter: AlbumCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
}

extension AlbumTableViewCell: AlbumTableViewCellProtocol {
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.songImageView.image = image
        }
    }
    
    func setSongName(_ text: String) {
        self.songNameLabel.text = text
    }
    
    func setArtistName(_ text: String) {
        self.artistNameLabel.text = text
    }
}
