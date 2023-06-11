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
}

final class RecentlySearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var songLabel: UILabel!
    @IBOutlet private var artistLabel: UILabel!
    
    var cellPresenter: RecentlySearchCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
}

extension RecentlySearchCollectionViewCell: RecentlySearchCellProtocol {
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func setSongName(_ text: String) {
        self.songLabel.text = text
    }
    
    func setArtistName(_ text: String) {
        self.artistLabel.text = text
    }
}
