//
//  MusicController.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 04/05/23.
//

import SwiftUI
import AVFoundation

class MusicController: ObservableObject{
    @Published var audioPlayer: AVAudioPlayer?
    func playMapMusic() {
        guard let url = Bundle.main.url(forResource: "Map", withExtension: "mpeg") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
            audioPlayer?.setVolume(0.3, fadeDuration: 0.5)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playGameMusic() {
        guard let url = Bundle.main.url(forResource: "Game", withExtension: "mpeg") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
            audioPlayer?.setVolume(0.3, fadeDuration: 0.5)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
