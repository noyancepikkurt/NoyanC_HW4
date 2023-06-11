//
//  DetailViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func setSongTitle(_ text: String)
    func setSongArtistName(_ text: String)
    func setSongKindName(_ text: String)
    func setSongImage(_ image: UIImage)
    func setSongTrackPrice(_ text: String)
    func setSongCollectionPrice(_ text: String)
    func updateButton()
    func setupVideoImage(_ isThereVideoURL: Bool)
}

final class DetailViewController: UIViewController {
    @IBOutlet private var detailImageView: UIImageView!
    @IBOutlet private var detailArtistNameLabel: UILabel!
    @IBOutlet private var detailSongNameLabel: UILabel!
    @IBOutlet private var detailKindLabel: UILabel!
    @IBOutlet private var detailTrackPrice: UILabel!
    @IBOutlet private var detailCollectionPrice: UILabel!
    @IBOutlet private var detailAudioButton: UIButton!
    @IBOutlet private var likeImage: UIButton!
    @IBOutlet private weak var videoButtonImage: UIImageView!
    
    var presenter: DetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        favoriteButtonForLoad()
        setGradientBackground()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.stopAudio()
        stopAudio()
    }
    
    @IBAction private func detailAudioButtonAction(_ sender: Any) {
        presenter.requestForAudio()
    }
    
    @IBAction private func likeButtonAction(_ sender: Any) {
        if presenter.isFavorite() {
            UIAlertController.alertActionMessage(title: AlertMessages.deleteFavoriteTitle.rawValue,
                                                 message: AlertMessages.deleteFavoriteMessage.rawValue,
                                                 vc: self) { [weak self] bool in
                guard let self else { return }
                if bool {
                    self.favoriteButtonSetup()
                    self.presenter.likeButtonClicked()
                }
            }
        } else {
            self.favoriteButtonSetup()
            self.presenter.likeButtonClicked()
        }
    }
    
    func setupVideoImage(_ isThereVideoURL: Bool) {
        videoButtonImage.isHidden = isThereVideoURL ? false : true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        videoButtonImage.addGestureRecognizer(tapGesture)
        videoButtonImage.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped() {
        guard let videoURL = presenter.videoURL else { return }
        AudioManager.shared.showVideo(from: videoURL, presentingViewController: self)
    }
    
    private func favoriteButtonSetup() {
        let fillImg = UIImage(systemName: Icons.fillStar.rawValue)
        let img = UIImage(systemName: Icons.emptyStar.rawValue)
        let buttonImage = presenter.isFavorite() ? img : fillImg
        likeImage.setImage(buttonImage, for: .normal)
    }
    
    private func favoriteButtonForLoad() {
        let fillImg = UIImage(systemName: Icons.fillStar.rawValue)
        let img = UIImage(systemName: Icons.emptyStar.rawValue)
        let buttonImage = presenter.isFavorite() ? fillImg : img
        likeImage.setImage(buttonImage, for: .normal)
    }
    
    private func stopAudio() {
        presenter.isAudioPlaying = false
        detailAudioButton.setImage(UIImage(systemName: Icons.playIcon.rawValue), for: .normal)
        AudioTimerHelper.removeExistingProgressLayers(from: detailAudioButton)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func updateButton() {
        if presenter.isAudioPlaying {
            AudioTimerHelper.startProgressAnimation(in: detailAudioButton, duration: 31, delegate: self)
            detailAudioButton.setImage(UIImage(systemName: Icons.pauseIcon.rawValue), for: .normal)
        } else {
            detailAudioButton.setImage(UIImage(systemName: Icons.playIcon.rawValue), for: .normal)
            AudioTimerHelper.removeExistingProgressLayers(from: detailAudioButton)
        }
    }
    
    func setSongTitle(_ text: String) {
        self.detailSongNameLabel.text = text
    }
    
    func setSongArtistName(_ text: String) {
        self.detailArtistNameLabel.text = text
    }
    
    func setSongKindName(_ text: String) {
        self.detailKindLabel.text = text
    }
    
    func setSongImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.detailImageView.image = image
        }
    }
    
    func setSongTrackPrice(_ text: String) {
        self.detailTrackPrice.text = text
    }
    
    func setSongCollectionPrice(_ text: String) {
        self.detailCollectionPrice.text = text
    }
}

extension DetailViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            stopAudio()
        }
    }
}

