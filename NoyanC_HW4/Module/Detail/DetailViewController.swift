//
//  DetailViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit
import SongAPI

protocol DetailViewControllerProtocol: AnyObject {
    func setSongTitle(_ text: String)
    func setSongArtistName(_ text: String)
    func setSongKindName(_ text: String)
    func setSongImage(_ image: UIImage)
    func setSongTrackPrice(_ text: String)
    func setSongCollectionPrice(_ text: String)
    func getSource() -> SongDetail?
}

final class DetailViewController: UIViewController {
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailArtistNameLabel: UILabel!
    @IBOutlet var detailSongNameLabel: UILabel!
    @IBOutlet var detailKindLabel: UILabel!
    @IBOutlet var detailTrackPrice: UILabel!
    @IBOutlet var detailCollectionPrice: UILabel!
    @IBOutlet var detailAudioButton: UIButton!
    @IBOutlet var likeImage: UIButton!
    
    var source: SongDetail?
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
    
    @IBAction func detailAudioButtonAction(_ sender: Any) {
        presenter.requestForAudio()
        updateButton()
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        if presenter.isFavorite() {
            UIAlertController.alertActionMessage(title: "test", message: "deneme", vc: self) { [weak self] bool in
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
    
    private func favoriteButtonSetup() {
        let fillImg = UIImage(systemName: "star.fill")
        let img = UIImage(systemName: "star")
        let buttonImage = presenter.isFavorite() ? img : fillImg
        likeImage.setImage(buttonImage, for: .normal)
    }
    
    private func favoriteButtonForLoad() {
        let fillImg = UIImage(systemName: "star.fill")
        let img = UIImage(systemName: "star")
        let buttonImage = presenter.isFavorite() ? fillImg : img
        likeImage.setImage(buttonImage, for: .normal)
    }
    
    private func updateButton() {
        if presenter.isAudioPlaying {
            detailAudioButton.setImage(UIImage(systemName: Icons.playIcon.rawValue), for: .normal)
            AudioTimerHelper.removeExistingProgressLayers(from: detailAudioButton)
        } else {
            AudioTimerHelper.startProgressAnimation(in: detailAudioButton, duration: 31, delegate: self)
            detailAudioButton.setImage(UIImage(systemName: Icons.pauseIcon.rawValue), for: .normal)
        }
    }
    
    private func stopAudio() {
        presenter.isAudioPlaying = false
        detailAudioButton.setImage(UIImage(systemName: Icons.playIcon.rawValue), for: .normal)
        AudioTimerHelper.removeExistingProgressLayers(from: detailAudioButton)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
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
    
    func getSource() -> SongDetail? {
        return source
    }
}

extension DetailViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            stopAudio()
        }
    }
}

