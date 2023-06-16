//
//  PopularCollectionViewCell.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import UIKit

protocol RecentlySearchCellProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setSongName(_ text: String)
    func setArtistName(_ text: String)
    func showIndicator()
    func hideIndicator()
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
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.imageView.image = image
        }
    }
    
    func setSongName(_ text: String) {
        self.songLabel.text = text
    }
    
    func setArtistName(_ text: String) {
        self.artistLabel.text = text
    }
    
    func showIndicator() {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }
    
    func hideIndicator() {
        self.indicator.stopAnimating()
    }
}
