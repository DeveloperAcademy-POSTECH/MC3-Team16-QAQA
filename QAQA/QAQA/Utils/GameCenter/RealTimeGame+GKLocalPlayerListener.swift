//
//  RealTimeGame+GKLocalPlayerListener.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/12.
//

import Foundation
import GameKit
import SwiftUI

extension RealTimeGame: GKLocalPlayerListener {
    func player(_ player: GKPlayer, didRequestMatchWithRecipients recipientPlayers: [GKPlayer]) {
        print("\n\nSending invites to other players.")
    }

    func player(_ player: GKPlayer, didAccept invite: GKInvite) {
        if let viewController = GKMatchmakerViewController(invite: invite) {
            viewController.matchmakerDelegate = self
            rootViewController?.present(viewController, animated: true) { }
        }
    }
}
