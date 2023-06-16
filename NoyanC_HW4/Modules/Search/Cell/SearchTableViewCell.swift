//
//  DetailTableViewCell.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit

protocol VideoButtonDelegate: AnyObject {
    func videoButtonTapped(withURL url: URL)
}

protocol SearchCellProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setSongName(_ text: String)
    func setArtistName(_ text: String)
    func setAlbumName(_ text: String)
    func updateButton()
    func hideLoadingView()
    func setupVideoImage(_ isThereVideoURL: Bool)
    func showIndicator()
    func hideIndicator()
}

final class SearchTableViewCell: UITableViewCell {
    @IBOutlet private var detailImageView: UIImageView!
    @IBOutlet private var songNameLabel: UILabel!
    @IBOutlet private var artistNameLabel: UILabel!
    @IBOutlet private var albumNameLabel: UILabel!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var imageIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var videoButton: UIButton!
    @IBOutlet var audioButtonImage: UIButton!
    
    weak var delegate: VideoButtonDelegate?
    
    var cellPresenter: SearchCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        detailImageView.image = nil
        if cellPresenter.isAudioPlaying {
            stopAudio()
        }
    }
    
    @IBAction func videoButtonAction(_ sender: Any) {
        guard let url = cellPresenter.videoURL else { return }
        delegate?.videoButtonTapped(withURL: url)
    }
    
    func setupVideoImage(_ isThereVideoURL: Bool) {
        videoButton.isHidden = isThereVideoURL ? false : true
    }
    
    func audioButtonAction() {
        audioButtonImage.isHidden = true
        indicator.isHidden = false
        indicator.startAnimating()
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
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
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
    
    func hideLoadingView() {
        audioButtonImage.isHidden = false
        indicator.isHidden = true
    }
    
    func showIndicator() {
        self.imageIndicator.isHidden = false
        self.imageIndicator.startAnimating()
    }
    
    func hideIndicator() {
        self.imageIndicator.stopAnimating()
    }
}

extension SearchTableViewCell: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            stopAudio()
        }
    }
}
