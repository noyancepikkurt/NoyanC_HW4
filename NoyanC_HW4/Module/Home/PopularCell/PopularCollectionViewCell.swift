//
//  PopularCollectionViewCell.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import UIKit
import SongAPI

protocol PopularCellProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setSongName(_ text: String)
    func setArtistName(_ text: String)
}

final class PopularCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var songLabel: UILabel!
    @IBOutlet private var artistLabel: UILabel!
    
    var cellPresenter: PopularCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }

}

extension PopularCollectionViewCell: PopularCellProtocol {
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
