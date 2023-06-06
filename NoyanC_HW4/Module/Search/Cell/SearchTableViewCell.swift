//
//  DetailTableViewCell.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit
import SongAPI
import SDWebImage

class SearchTableViewCell: UITableViewCell {

    @IBOutlet private var detailImageView: UIImageView!
    @IBOutlet private var songNameLabel: UILabel!
    @IBOutlet private var artistNameLabel: UILabel!
    @IBOutlet private var albumNameLabel: UILabel!
    

    func setup(_ model: SongModel, index: Int) {
        preparePosterImage(with: model.results?[index].artworkUrl100)
        songNameLabel.text = model.results?[index].trackName
        artistNameLabel.text = model.results?[index].artistName
        albumNameLabel.text = model.results?[index].collectionName
    }
    
    private func preparePosterImage(with urlString: String?) {
        guard let fullPath = urlString else { return }
        if let url = URL(string: fullPath) {
            detailImageView.sd_setImage(with: url) { [weak self] _,_,_,_ in
            }
        }
    }
}
