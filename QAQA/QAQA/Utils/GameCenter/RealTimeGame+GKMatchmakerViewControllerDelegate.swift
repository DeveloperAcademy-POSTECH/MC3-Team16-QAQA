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
    func matchmakerViewController(_ viewController: GKMatchmakerViewController,
                                  didFind match: GKMatch) {
        viewController.dismiss(animated: true) { }
        
        if !playingGame && match.expectedPlayerCount == 0 {
            startMyMatchWith(match: match)
        }
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }

    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print("\n\nMatchmaker view controller fails with error: \(error.localizedDescription)")
    }
}
