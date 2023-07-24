//
//  RealTimeGame+MatchData.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/12.
//

import Foundation
import GameKit
import SwiftUI

// MARK: Game Data Objects

struct GameData: Codable {
    var matchName: String
    var playerName: String
    var score: Int?
    var outcome: String?
    var goodReaction: Bool?
    var notGoodReaction: Bool?
}

extension RealTimeGame {
    
    // MARK: Codable Game Data
    
    func encode(playReaction: Bool) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, goodReaction: playReaction)
        return encode(gameData: gameData)
    }
    // 범프 오브 치킨 ??
    /// Creates a data representation of the local player's score for sending to other players.
    ///
    /// - Returns: A representation of game data that contains only the score.
    func encode(score: Int) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, score: score, outcome: nil)
        return encode(gameData: gameData)
    }
    
    /// Creates a data representation of the game outcome for sending to other players.
    ///
    /// - Returns: A representation of game data that contains only the game outcome.
    func encode(outcome: String) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, score: nil, outcome: outcome)
        return encode(gameData: gameData)
    }
    
    /// Creates a data representation of game data for sending to other players.
    ///
    /// - Returns: A representation of game data.
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
    
    /// Decodes a data representation of match data from another player.
    ///
    /// - Parameter matchData: A data representation of the game data.
    /// - Returns: A game data object.
    func decode(matchData: Data) -> GameData? {
        // Convert the data object to a game data object.
        return try? PropertyListDecoder().decode(GameData.self, from: matchData)
    }
}
