//
//  FeaturedCollectionViewCell.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import UIKit

final class FeaturedCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    
    func setup(_ imageArray: UIImage) {
        self.imageView.image = imageArray
    }
}
