//
//  SearchCellPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit
import SongAPI
import AVFoundation

protocol SearchCellPresenterProtocol: AnyObject {
    func load()
    func requestForAudio()
    var isAudioPlaying: Bool { get set }
}

final class SearchCellPresenter {
    weak var view: SearchCellProtocol?
    private let song: SongDetail
    private var audioPlayer: AVAudioPlayer?
    var isAudioPlaying: Bool = false
    
    init(view: SearchCellProtocol,
         song: SongDetail) {
        self.view = view
        self.song = song
    }
}

extension SearchCellPresenter: SearchCellPresenterProtocol {
    func load() {
        ImageDownloader.shared.image(songs: song) { data, error in
            if let data {
                guard let image = UIImage(data: data) else { return }
                self.view?.setImage(image)
            }
        }
        view?.setSongName(song.trackName ?? "")
        view?.setAlbumName(song.collectionName ?? "")
        view?.setArtistName(song.artistName ?? "")
    }
    
    func requestForAudio() {
        guard let songAudioURL = song.previewURL else { return }
        NetworkService.shared.requestAudio(url: URL(string: songAudioURL)!) {[weak self] audioPlay in
            guard let self else { return }
            
            if isAudioPlaying {
                self.audioPlayer = audioPlay
                self.audioPlayer?.pause()
                self.isAudioPlaying = false
            } else {
                self.audioPlayer = audioPlay
                self.audioPlayer?.play()
                self.isAudioPlaying = true
            }
        }
    }
}
