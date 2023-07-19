//
//  RealTimeGame+Friends.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import Foundation
import GameKit
import SwiftUI

/// A message that one player sends to another.
struct Friend: Identifiable {
    var id = UUID()
    var player: GKPlayer
}

extension RealTimeGame {
    /// Presents the friends request view controller.
    /// - Tag:addFriends
    /// 플레이어가 친구요청을 할 수 있도록 메세지 시트와 함께 ViewController 를 제공하는 함수입니다.
    func addFriends() {
        if let viewController = rootViewController {
            do {
                try GKLocalPlayer.local.presentFriendRequestCreator(from: viewController)
            } catch {
                print("Error: \(error.localizedDescription).")
            }
        }
    }
    
    /// Attempts to access the local player's friends if they grant permission.
    /// - Tag:accessFriends
    /// 로컬 플레이어의 친구에게 액세스를 시도하는 코드입니다.
    func accessFriends() async {
        do {
            // 플레이어가 친구 목록에 액세스할 수 있는 권한을 부여합니다.
            let authorizationStatus = try await GKLocalPlayer.local.loadFriendsAuthorizationStatus()
            
            // Creates an array of identifiable friend objects for SwiftUI.
            // SwiftUI를 위한 식별 가능한 친구 Object의 배열을 만들어줍니다.
            let loadFriendsClosure: ([GKPlayer]) -> Void = { [self] players in
                for player in players {
                    let friend = Friend(player: player)
                    friends.append(friend)
                }
            }
            
            // 친구의 권한 부여 상태를 처리합니다.
            // Handle the friend's authorization status.
            switch authorizationStatus {
            case .notDetermined:
                // 로컬 플레이어가 친구에 대한 액세스를 거부하거나 승인하지 않은 경우
                // The local player hasn't denied or authorized access to their friends.
                
                // 로컬 플레이어에게 친구 목록에 액세스할 수 있는 권한을 요청합니다.
                // Ask the local player for permission to access their friends list.
                // This may present a system prompt that might pause the game.
                let players = try await GKLocalPlayer.local.loadFriends()
                loadFriendsClosure(players)
            case .denied:
                // The local player denies access their friends.
                print("authorizationStatus: denied")
            case .restricted:
                // The local player has restrictions on sharing their friends.
                print("authorizationStatus: restricted")
            case .authorized:
                // The local player authorizes your app's request to access their friends.
    
                // Load the local player's friends.
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
