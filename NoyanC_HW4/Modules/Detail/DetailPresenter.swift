//
//  DetailPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import SongAPI
import AVFoundation
import SDWebImage

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func likeButtonClicked()
    func isFavorite() -> Bool
    func requestForAudio()
    var isAudioPlaying: Bool { get set }
    func stopAudio()
    var source: SongDetail? { get set }
    var videoURL: URL? { get set }
}

final class DetailPresenter {
    unowned var view: DetailViewControllerProtocol!
    var interactor: DetailInteractorProtocol!
    private var songDetail: SongDetail?
    private var audioPlayer: AVAudioPlayer?
    var isAudioPlaying: Bool = false
    var source: SongDetail?
    var videoURL: URL?
    
    init(view: DetailViewControllerProtocol,
         interactor: DetailInteractorProtocol!) {
        self.view = view
        self.interactor = interactor
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func stopAudio() {
        AudioManager.shared.stopMusic()
    }
    
    func isFavorite() -> Bool {
        guard let songDetail else { return false }
        return CoreDataManager.shared.isSongDetailFavorite(songDetail)
    }
    
    func likeButtonClicked(){
        guard let songDetail else { return }
        interactor.saveOrDelete(songDetail)
    }
    
    func viewDidLoad() {
        songDetail = source
        guard let songDetail else { return }
        guard let trackPrice = songDetail.trackPrice else { return }
        guard let collectionPrice = songDetail.collectionPrice else { return }
        view.setSongTitle(songDetail.trackName ?? "")
        view.setSongArtistName(songDetail.artistName ?? "")
        view.setSongKindName(songDetail.primaryGenreName ?? "")
        view.setSongTrackPrice("Track Price: \(String(describing: trackPrice)) TRY")
        view.setSongCollectionPrice("Collection Price: \(String(describing: collectionPrice)) TRY")
        
        guard let imageUrl = songDetail.artworkUrl100 else { return }
        let qualityImageUrl = ImageUrlTransform.shared.improveQuality(imageUrl)
        SDWebImageManager.shared.loadImage(with: URL(string: qualityImageUrl), context: nil, progress: nil) { image, _, error, _, _, _ in
            if let image {
                self.view.setSongImage(image)
            }
        }
        
        if let previewURL = songDetail.previewURL {
            let url = URL(string: previewURL)
            if url?.pathExtension == "m4v" {
                self.videoURL = url
                view.setupVideoImage(true)
            } else {
                view.setupVideoImage(false)
            }
        }
    }
    
    func requestForAudio() {
        guard let songAudioURL = songDetail?.previewURL else { return }
        NetworkService.shared.requestAudio(url: URL(string: songAudioURL)!) {[weak self] audioPlay in
            guard let self else { return }
            self.audioPlayer = audioPlay
            
            if isAudioPlaying {
                AudioManager.shared.stopMusic { bool in
                    self.isAudioPlaying = bool
                }
            } else {
                guard let audioPlayer = self.audioPlayer else { return }
                AudioManager.shared.playMusic(audioPlayer: audioPlayer) { bool in
                    self.isAudioPlaying = true
                }
            }
            self.view.hideLoadingView()
            self.view.updateButton()
        }
    }
}

