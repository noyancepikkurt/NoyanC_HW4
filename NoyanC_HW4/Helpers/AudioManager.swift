//
//  AudioManager.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import AVFoundation
import AVKit

final class AudioManager {
    static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?
    var videoURL: URL?
    
    private init() {}
    
    func playMusic(audioPlayer: AVAudioPlayer, completion: @escaping (Bool) -> Void) {
        self.audioPlayer = audioPlayer
        self.audioPlayer?.prepareToPlay()
        self.audioPlayer?.play()
        completion(true)
    }
    
    func stopMusic(completion: ((Bool) -> Void)? = nil) {
        audioPlayer?.stop()
        completion?(false)
    }
    
    func showVideo(from url: URL, presentingViewController: UIViewController) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        presentingViewController.present(playerViewController, animated: true) {
            player.play()
        }
    }
}

