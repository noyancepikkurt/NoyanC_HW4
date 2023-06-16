//
//  SearchCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import SongAPI
import AVFoundation
import SDWebImage

protocol SearchCellPresenterProtocol: AnyObject {
    func load()
    func requestForAudio()
    var isAudioPlaying: Bool { get set }
    var videoURL: URL? { get set }
}

final class SearchCellPresenter {
    weak var view: SearchCellProtocol?
    let song: SongDetail
    private var selectedIndex: IndexPath?
    private var audioPlayer: AVAudioPlayer?
    var isAudioPlaying: Bool = false
    var videoURL: URL?
    
    init(view: SearchCellProtocol,
         song: SongDetail){
        self.view = view
        self.song = song
    }
}

extension SearchCellPresenter: SearchCellPresenterProtocol {
    func load() {
        view?.setSongName(song.trackName ?? "")
        view?.setAlbumName(song.collectionName ?? "")
        view?.setArtistName(song.artistName ?? "")
        
        view?.showIndicator()
        guard let imageUrl = song.artworkUrl100 else { return }
        let qualityImageUrl = ImageUrlTransform.shared.improveQuality(imageUrl)
        SDWebImageManager.shared.loadImage(with: URL(string: qualityImageUrl), context: nil, progress: nil) { [weak self] image, _, error, _, _, _ in
            guard let self else { return }
            if let image {
                self.view?.setImage(image)
                self.view?.hideIndicator()
            }
        }
        
        if let previewURL = song.previewURL {
            let url = URL(string: previewURL)
            if url?.pathExtension == "m4v" {
                self.videoURL = url
                AudioManager.shared.videoURL = url
                view?.setupVideoImage(true)
            } else {
                view?.setupVideoImage(false)
            }
        }
    }
    
    func requestForAudio()  {
        guard let songAudioURL = song.previewURL else { return }
        NetworkService.shared.requestAudio(url: URL(string: songAudioURL)!) {[weak self] audioPlay in
            guard let self else { return }
            self.audioPlayer = audioPlay
            
            if self.isAudioPlaying {
                AudioManager.shared.stopMusic { bool in
                    self.isAudioPlaying = bool
                }
            } else {
                guard let audioPlayer = self.audioPlayer else { return }
                AudioManager.shared.playMusic(audioPlayer: audioPlayer) { bool in
                    self.isAudioPlaying = bool
                }
            }
            self.view?.updateButton()
            self.view?.hideLoadingView()
        }
    }
}
