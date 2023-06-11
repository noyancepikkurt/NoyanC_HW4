//
//  DetailPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit // UIImage
import SongAPI
import AVFoundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func likeButtonClicked()
    func isFavorite() -> Bool
    func requestForAudio()
    var isAudioPlaying: Bool { get set }
    func stopAudio()
    var source: SongDetail? { get set }
}

final class DetailPresenter {
    unowned var view: DetailViewControllerProtocol!
    let router: DetailRouterProtocol!
    var interactor: DetailInteractorProtocol!
    private var songDetail: SongDetail?
    private var audioPlayer: AVAudioPlayer?
    var isAudioPlaying: Bool = false
    var source: SongDetail?
    
    init(view: DetailViewControllerProtocol,
         router: DetailRouterProtocol,
         interactor: DetailInteractorProtocol!) {
        self.view = view
        self.router = router
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
        
        ImageDownload.shared.image(songs: songDetail) { data, error in
            guard let data  = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            self.view.setSongImage(image)
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
        }
    }
}

