//
//  ReactionSoundViewModel.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/26.
//

import Foundation
import AVKit

class ReactionSoundViewModel: ObservableObject {
    private var reactionSoundModel = ReactionSoundModel()
    
    var player: AVAudioPlayer?

    func playSound(sound: SoundOption, loop: Int = -1) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {
            return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = loop
            player?.play()
        } catch _ {
            print("오류 발생")
        }
    }
    func createRandomEvaReactionSounds() -> SoundOption {
        return reactionSoundModel.reactionEvaSounds.randomElement()!
    }
    func createRandomKingjungReactionSounds() -> SoundOption {
        return reactionSoundModel.reactionKingjungSounds.randomElement()!
    }
    
    
    func createBoomBgm() -> SoundOption {
        return reactionSoundModel.boomBgm[0]
    }
    
    func createBoomCreate() -> SoundOption {
        return reactionSoundModel.boomCreate[0]
    }
    
    func createBoomFanfare() -> SoundOption {
        return reactionSoundModel.boomFanfare[0]
    }
    
    func createGraphBubblePop() -> SoundOption {
        return reactionSoundModel.graphBubblePop[0]
    }
    
    func createGraphMeet() -> SoundOption {
        return reactionSoundModel.graphMeet[0]
    }
    
    func stopSound() {
        player?.stop()
    }
}
