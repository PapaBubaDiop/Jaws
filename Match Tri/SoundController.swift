//
//  SoundController.swift
//  Pow2
//
//  Created by Vadim Bashurov on 3/19/16.
//

import UIKit
import AVFoundation

class SoundController {
 
    
    let audioFiles: [(String, String)] = [
        ("piratesof", "mp3"),
        ("s1",  "wav"),
        ("trump",  "mp3"),
        ("walk", "m4a"),
        ("Combo1", "mp3"),
        ("Combo2", "mp3"),
        ("start", "caf"),
        ("puck_get_01", "aac"),
        ("puck_get_03", "aac"),
        ("tick",  "wav"),
        ("HittingBasketBoard", "mp3"),
        ("swipe", "mp3"),
        ("s4",  "wav"),
        ]

    
 
   var players : [AVAudioPlayer] = []
    var volume = 0.0
    
    init () {
        for mf in audioFiles {
            
            
            let a1 = self.setupAudioPlayerWithFile(mf.0 as NSString, type:mf.1 as NSString)
            players.append(a1!)
        }
    }
    
    func setVolume(_ v:Double) {
        volume = v
        for audioPlayer in players {
            audioPlayer.volume = Float(volume)
        }
    }
    
    func playSound(_ i:Int)
    {
        let audioPlayer = players[i]
        audioPlayer.play()
    }
    
    func setupAudioPlayerWithFile(_ file:NSString, type:NSString) -> AVAudioPlayer?  {
        let path = Bundle.main.path(forResource: file as String, ofType: type as String)
        let url = URL(fileURLWithPath: path!)
        var audioPlayer:AVAudioPlayer?
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            audioPlayer!.prepareToPlay()
            
        } catch {
            print("Player not available")
        }
        return audioPlayer
    }
}
