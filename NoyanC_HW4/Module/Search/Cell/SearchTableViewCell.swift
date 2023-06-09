//
//  DetailTableViewCell.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit

protocol SearchCellProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setSongName(_ text: String)
    func setArtistName(_ text: String)
    func setAlbumName(_ text: String)
}

final class SearchTableViewCell: UITableViewCell {
    @IBOutlet private var detailImageView: UIImageView!
    @IBOutlet private var songNameLabel: UILabel!
    @IBOutlet private var artistNameLabel: UILabel!
    @IBOutlet private var albumNameLabel: UILabel!
    @IBOutlet var audioButtonImage: UIButton!
    
    var cellPresenter: SearchCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopAudio()
    }
    
    @IBAction func audioButtonAction(_ sender: Any) {
        cellPresenter.requestForAudio()
        updateButton()
    }
    
    private func stopAudio() {
        cellPresenter.isAudioPlaying = false
        audioButtonImage.setImage(UIImage(systemName: Icons.playIcon.rawValue), for: .normal)
        AudioTimerHelper.removeExistingProgressLayers(from: audioButtonImage)
    }
    
    
    private func updateButton() {
        AudioTimerHelper.startProgressAnimation(in: audioButtonImage, duration: 31, delegate: self)
        if cellPresenter.isAudioPlaying {
            audioButtonImage.setImage(UIImage(systemName: Icons.playIcon.rawValue), for: .normal)
            AudioTimerHelper.removeExistingProgressLayers(from: audioButtonImage)
        } else {
            audioButtonImage.setImage(UIImage(systemName: Icons.pauseIcon.rawValue), for: .normal)
        }
    }
}

extension SearchTableViewCell: SearchCellProtocol {
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.detailImageView.image = image
        }
    }
    
    func setSongName(_ text: String) {
        self.songNameLabel.text = text
    }
    
    func setArtistName(_ text: String) {
        self.artistNameLabel.text = text
    }
    
    func setAlbumName(_ text: String) {
        self.albumNameLabel.text = text
    }
}

extension SearchTableViewCell: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            stopAudio()
        }
    }
}
