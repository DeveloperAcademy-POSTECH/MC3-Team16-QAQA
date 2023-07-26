//
//  RealTimeGame+GKGameCenterViewController.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import Foundation
import GameKit
import SwiftUI

extension RealTimeGame {
    func showProgress() {
        let viewController = GKGameCenterViewController(achievementID: "1234")
        viewController.gameCenterDelegate = self
        
        rootViewController?.present(viewController, animated: true) { }
    }

    func topScore() {
        let viewController = GKGameCenterViewController(leaderboardID: "123", playerScope: GKLeaderboard.PlayerScope.global,
                                                        timeScope: GKLeaderboard.TimeScope.allTime)
        viewController.gameCenterDelegate = self
        rootViewController?.present(viewController, animated: true) { }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}
