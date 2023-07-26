//
//  RealTimeGame+Friends.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import Foundation
import GameKit
import SwiftUI

struct Friend: Identifiable {
    var id = UUID()
    var player: GKPlayer
}

extension RealTimeGame {
    func addFriends() {
        if let viewController = rootViewController {
            do {
                try GKLocalPlayer.local.presentFriendRequestCreator(from: viewController)
            } catch {
                print("Error: \(error.localizedDescription).")
            }
        }
    }

    func accessFriends() async {
        do {
            let authorizationStatus = try await GKLocalPlayer.local.loadFriendsAuthorizationStatus()
            let loadFriendsClosure: ([GKPlayer]) -> Void = { [self] players in
                for player in players {
                    let friend = Friend(player: player)
                    friends.append(friend)
                }
            }
            
            switch authorizationStatus {
            case .notDetermined:
                let players = try await GKLocalPlayer.local.loadFriends()
                loadFriendsClosure(players)
            case .denied:
                print("authorizationStatus: denied")
            case .restricted:
                print("authorizationStatus: restricted")
            case .authorized:
                let players = try await GKLocalPlayer.local.loadFriends()
                loadFriendsClosure(players)
            @unknown default:
                print("authorizationStatus: unknown")
            }
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
}
