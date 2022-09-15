//
//  SoundPlayer.swift
//  Devote
//
//  Created by hazem smawy on 9/14/22.
//

import Foundation
import AVFoundation


var audioPlayer : AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch {
            print("could not find and play the sound file.")
        }
       
    }
}
