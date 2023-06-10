//
//  AudioManager.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 9.06.2023.
//

import AVFoundation

final class AudioManager {
    static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func playMusic(audioPlayer: AVAudioPlayer, completion: @escaping (Bool) -> Void) {
        self.audioPlayer = audioPlayer
        self.audioPlayer?.prepareToPlay()
        self.audioPlayer?.play()
        completion(true)
    }
    
    func stopMusic(completion: ((Bool) -> Void)? = nil) {
        audioPlayer?.stop()
        audioPlayer = nil
        completion?(false)
    }
}

