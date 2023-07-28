//
//  RealTimeGame+GKMatchDelegate.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import Foundation
import GameKit
import SwiftUI

extension RealTimeGame: GKMatchDelegate {
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        switch state {
        case .connected:
            print("\(player.displayName) Connected")
            if match.expectedPlayerCount == 0 {
                opponent = match.players[0]
            }
        case .disconnected:
            print("\(player.displayName) Disconnected")
        default:
            print("\(player.displayName) Connection Unknown")
        }
    }
    
    func match(_ match: GKMatch, didFailWithError error: Error?) {
        print("\n\nMatch object fails with error: \(error!.localizedDescription)")
    }

    func match(_ match: GKMatch, shouldReinviteDisconnectedPlayer player: GKPlayer) -> Bool {
        return false
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        let gameData = decode(matchData: data)
        
        if let score = gameData?.score {
            opponentScore = score
        } else if (gameData?.outcome) != nil {
            gameIsEnd = true
        } else if let reaction = gameData?.isPlayingReaction, let reactionState = gameData?.isGoodReaction, let allReactionScore = gameData?.reactionScore {
            withAnimation(.spring(response: 0.2,dampingFraction: 0.25,blendDuration: 0.0)){
                playReaction = reaction
                isGoodReaction = reactionState
                reactionScore = allReactionScore
            }
        } else if let timerModal = gameData?.showTimerModal, let timer = gameData?.isTimer {
            showTimerModal = timerModal
            isTimer = timer
        } else if let min = gameData?.countMin, let second = gameData?.countSecond {
            countMin = min
            countSecond = second
        }
    }
}
