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
        if !playingGame && match.expectedPlayerCount == 0 { // expectedPlayerCount 수는, 초대는 받았지만 아직 게임에 연결되지 않은 플레이어 수를 의미합니다. 아직 게임이 시작되지 않은 상태이고, 모든 플레이어가 연결이 완료되면 게임을 시작합니다. GameKit은 expectedPlayerCount 수가 0이 되면 게임을 시작하게 합니다.
            startMyMatchWith(match: match)
        }
    }
    
    /// Dismisses the matchmaker interface when either player cancels matchmaking.
    /// 플레이어가 matchmaking 을 취소하면 인터페이스를 사라지게 합니다.
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    /// Reports an error during the matchmaking process.
    /// matchmaking 에러 보고
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print("\n\nMatchmaker view controller fails with error: \(error.localizedDescription)")
    }
}
