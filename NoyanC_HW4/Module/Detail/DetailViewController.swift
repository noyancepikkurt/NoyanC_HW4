//
//  DetailViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit
import SongAPI

protocol DetailViewControllerProtocol: AnyObject {
    func setTitle(_ title: String)
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
    
    var source: SongDetail?
    var presenter: DetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setGradientBackground()
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func setTitle(_ title: String) {
        self.title = title
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
    
    func getSource() -> SongDetail? {
        return source
    }
}
