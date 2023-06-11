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
    func updateButton()
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
        detailImageView.image = nil
        stopAudio()
    }
    
    func audioButtonAction() {
        cellPresenter.requestForAudio()
    }
    
    func stopAudio() {
        AudioManager.shared.stopMusic { [weak self] bool in
            guard let self else { return }
            self.cellPresenter.isAudioPlaying = bool
            self.audioButtonImage.setImage(UIImage(systemName: Icons.playIcon.rawValue), for: .normal)
            AudioTimerHelper.removeExistingProgressLayers(from: self.audioButtonImage)
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
    
    func updateButton() {
        if cellPresenter.isAudioPlaying {
            AudioTimerHelper.startProgressAnimation(in: audioButtonImage, duration: 31, delegate: self)
            audioButtonImage.setImage(UIImage(systemName: Icons.pauseIcon.rawValue), for: .normal)
        } else {
            audioButtonImage.setImage(UIImage(systemName: Icons.playIcon.rawValue), for: .normal)
            AudioTimerHelper.removeExistingProgressLayers(from: audioButtonImage)
        }
    }
}

extension SearchTableViewCell: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            stopAudio()
        }
    }
}
