//
//  SoundHandler.swift
//  Memorization Exercise Game
//
//  Created by Kien Phan on 1/7/18.
//  Copyright © 2018 Kien Phan. All rights reserved.
//

import Foundation
import AVFoundation

class SoundHandler {
    
    var player = AVAudioPlayer()
    
    func play(resource: String, type: String) {
        
        var url = URL(fileURLWithPath: Bundle.main.path(forResource: "note1", ofType: "wav")!)
        
        if let path = Bundle.main.path(forResource: resource, ofType: type){
            url = URL(fileURLWithPath: path)
        } else {
            print("NO SUCH FILE ERROR")
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.volume = 1
            player.play()
        } catch {
            print("SOUNDHANDLER COULD NOT LOAD FILE :(")
        }
        
    }
    
}
