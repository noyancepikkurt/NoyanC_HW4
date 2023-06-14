//
//  PopularCollectionViewCell.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import UIKit

protocol RecentlySearchCellProtocol: AnyObject {
    func setImage(_ imageURL: String)
    func setSongName(_ text: String)
    func setArtistName(_ text: String)
}

final class RecentlySearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var songLabel: UILabel!
    @IBOutlet private var artistLabel: UILabel!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    var cellPresenter: RecentlySearchCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
}

extension RecentlySearchCollectionViewCell: RecentlySearchCellProtocol {
    func setImage(_ imageURL: String) {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let updatedURL = ImageUrlTransform.shared.improveQuality(imageURL)
            self.imageView.sd_setImage(with: URL(string: updatedURL)) {_,_,_,_ in 
                self.indicator.stopAnimating()
            }
        }
    }
    
    func setSongName(_ text: String) {
        self.songLabel.text = text
    }
    
    func setArtistName(_ text: String) {
        self.artistLabel.text = text
    }
}
