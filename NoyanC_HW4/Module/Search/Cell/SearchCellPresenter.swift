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
    private var selectedIndex: IndexPath?
    private var audioPlayer: AVAudioPlayer?
    var isAudioPlaying: Bool = false
    
    init(view: SearchCellProtocol,
         song: SongDetail){
        self.view = view
        self.song = song
    }
}

extension SearchCellPresenter: SearchCellPresenterProtocol {
    func load() {
        ImageDownload.shared.image(songs: song) { data, error in
            if let data {
                guard let image = UIImage(data: data) else { return }
                self.view?.setImage(image)
            }
        }
        view?.setSongName(song.trackName ?? "")
        view?.setAlbumName(song.collectionName ?? "")
        view?.setArtistName(song.artistName ?? "")
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
        }
    }
}
