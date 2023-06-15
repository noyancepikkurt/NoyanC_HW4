//
//  AlbumTableViewCell.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import UIKit

protocol AlbumTableViewCellProtocol: AnyObject {
    func setImage(_ imageURL: String)
    func setSongName(_ text: String)
    func setArtistName(_ text: String)
}

final class AlbumTableViewCell: UITableViewCell {
    @IBOutlet private weak var songImageView: UIImageView!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    var cellPresenter: AlbumCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
}

extension AlbumTableViewCell: AlbumTableViewCellProtocol {
    func setImage(_ imageURL: String) {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let updatedURL = ImageUrlTransform.shared.improveQuality(imageURL)
            self.songImageView.sd_setImage(with: URL(string: updatedURL)) {_,_,_,_ in 
                self.indicator.stopAnimating()
            }
        }
    }
    
    func setSongName(_ text: String) {
        self.songNameLabel.text = text
    }
    
    func setArtistName(_ text: String) {
        self.artistNameLabel.text = text
    }
}

