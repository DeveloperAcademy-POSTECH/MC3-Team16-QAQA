//
//  RealTimeGame+GKMatchmakerViewControllerDelegate.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import Foundation
import GameKit
import SwiftUI

extension RealTimeGame: GKMatchmakerViewControllerDelegate {
    /// Dismisses the matchmaker interface and starts the game when a player accepts an invitation.
    func matchmakerViewController(_ viewController: GKMatchmakerViewController,
                                  didFind match: GKMatch) {
        // Dismiss the view controller.
        viewController.dismiss(animated: true) { }
        
        // Start the game with the player.
        // 게임을 시작하는 함수
        if !playingGame && match.expectedPlayerCount == 0 { // TODO: 왜 expectedPlayerCount가 0이어야하지?? -> 예상 참여 플레이어가 0이어야 게임이 끝났다는 뜻이라서??
            startMyMatchWith(match: match)
        }
    }
    
    /// Dismisses the matchmaker interface when either player cancels matchmaking.
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    /// Reports an error during the matchmaking process.
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print("\n\nMatchmaker view controller fails with error: \(error.localizedDescription)")
    }
}
