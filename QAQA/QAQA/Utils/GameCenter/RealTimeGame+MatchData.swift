//
//  RealTimeGame+MatchData.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/12.
//

import Foundation
import GameKit
import SwiftUI

struct GameData: Codable {
    var matchName: String
    var playerName: String
    var score: Int?
    var outcome: String?
    var isPlayingReaction: Bool?
    var isGoodReaction: Bool?
    var showTimerModal: Bool?
    var isTimer: Bool?
}

extension RealTimeGame {
    //TimerModal
    
    func encode(showTimerModal:Bool, isTimer: Bool) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, showTimerModal: showTimerModal, isTimer: isTimer)
        return encode(gameData: gameData)
    }
    
    func encode(playReaction: Bool, isGoodReaction: Bool) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, isPlayingReaction: playReaction, isGoodReaction: isGoodReaction)
        return encode(gameData: gameData)
    }

    func encode(score: Int) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, score: score, outcome: nil)
        return encode(gameData: gameData)
    }

    func encode(outcome: String) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, score: nil, outcome: outcome)
        return encode(gameData: gameData)
    }

    func encode(gameData: GameData) -> Data? {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(gameData)
            return data
        } catch {
            print("Error: \(error.localizedDescription).")
            return nil
        }
    }
    
    func decode(matchData: Data) -> GameData? {
        return try? PropertyListDecoder().decode(GameData.self, from: matchData)
    }
}
