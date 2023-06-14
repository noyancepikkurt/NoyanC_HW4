//
//  FavoritesTableViewCell.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import UIKit
import SDWebImage

protocol FavoritesCellProtocol: AnyObject {
    func setImage(_ imageURL: String)
    func setSongName(_ text: String)
    func setArtist(_ text: String)
    func setAlbum(_ text: String)
}

final class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet private var favoritesImageView: UIImageView!
    @IBOutlet private var favoritesSongName: UILabel!
    @IBOutlet private var favoritesArtistName: UILabel!
    @IBOutlet private var favoritesAlbumName: UILabel!
    
    var cellPresenter: FavoritesCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func prepareForReuse() {
        favoritesImageView.image = nil
    }
}

extension FavoritesTableViewCell: FavoritesCellProtocol {
    func setImage(_ imageURL: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let updatedURL = ImageUrlTransform.shared.improveQuality(imageURL)
            self.favoritesImageView.sd_setImage(with: URL(string: updatedURL))
        }
    }
    
    func setSongName(_ text: String) {
        self.favoritesSongName.text = text
    }
    
    func setArtist(_ text: String) {
        self.favoritesArtistName.text = text
    }
    
    func setAlbum(_ text: String) {
        self.favoritesAlbumName.text = text
    }
}
