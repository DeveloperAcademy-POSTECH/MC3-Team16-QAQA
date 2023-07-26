//
//  ReactionSoundViewModel.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/26.
//

import Foundation
import AVKit

class SoundSetting: ObservableObject {
    static let instance = SoundSetting()
    
    var player: AVAudioPlayer?
    
//    enum SoundOption: String {
//        case kingjung
//        case eva
//    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {
            return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch _ {
            print("오류 발생")
        }
    }
}
