//
//  SplashScreenViewController.swift
//  RickAndMortyInfo
//
//  Created by John Connolly on 4/26/19.
//  Copyright © 2019 John Connolly. All rights reserved.
//

import UIKit
import AVFoundation

class SplashScreenViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        playSound(soundName: "Rick-and-morty-theme", auidoPlayer: &audioPlayer)
    }
    
    func playSound(soundName: String, auidoPlayer: inout AVAudioPlayer) {
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("Error: Data from \(soundName) could not be played as an audio file")
            }
        } else {
            print("Error: Could not load the data from the file \(soundName)")
        }
    }

    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowTableView", sender: nil)
    }
    
    
    
    
}
