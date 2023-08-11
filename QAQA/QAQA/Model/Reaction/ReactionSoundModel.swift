//
//  ReactionSoundModel.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/26.
//

import Foundation

enum SoundOption: String {
    case kingjung, kingjung2, kingjung3, kingjung4, kingjung5, kingjung6, kingjung7, kingjung8, kingjung9, kingjung10, eva, eva2, eva3, eva4, eva5, eva6, boom_bgm, boom_create, boom_fanfare, graph_bubble_pop,graph_meet
}

class ReactionSoundModel: ObservableObject {
    let reactionEvaSounds: [SoundOption] = [.eva, .eva2, .eva3, .eva4, .eva5, .eva6]
    let reactionKingjungSounds: [SoundOption] = [.kingjung, .kingjung2, .kingjung3, .kingjung4, .kingjung5, .kingjung6, .kingjung7, .kingjung8, .kingjung9, .kingjung10]
    
    let boomBgm: [SoundOption] = [.boom_bgm]
    let boomCreate: [SoundOption] = [.boom_create]
    let boomFanfare: [SoundOption] = [.boom_fanfare]
    let graphBubblePop: [SoundOption] = [.graph_bubble_pop]
    let graphMeet: [SoundOption] = [.graph_meet]
}
