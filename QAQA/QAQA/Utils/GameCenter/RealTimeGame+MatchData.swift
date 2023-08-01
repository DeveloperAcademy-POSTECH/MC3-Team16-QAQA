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
    var outcome: String?
    // Reaction
    var isPlayingReaction: Bool?
    var isKingjungReaction: Bool?
    var reactionScore: Int?
    var allKingjuncScore: Int?
    var allEvaScore: Int?
    var myKingjungScore: Int?
    var myEvaScore: Int?
    // Timer
    var showTimerModal: Bool?
    var isTimer: Bool?
    var countMin: Int?
    var countSecond: Int?
    //햅틱부분
    var wasSuccessCalledHaptics: Bool? // new field
    var wasErrorCalledHaptics: Bool? // new field
    //햅틱부분
    var isBombAppear: Bool?
    var topicUserName: String?
    var isStartGame: Bool?
    var isShowResult: Bool?
    // QuestionStart
    var isStartQuestion: Bool?
    var isShowingBeginQuestionModal: Bool?
}

extension RealTimeGame {
    //TimerModal
    func encode(countMin: Int, countSecond: Int) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, countMin: countMin, countSecond: countSecond)
        return encode(gameData: gameData)
    }
    
    func encode(showTimerModal:Bool, isTimer: Bool) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, showTimerModal: showTimerModal, isTimer: isTimer)
        return encode(gameData: gameData)
    }
    func encode(isBombAppear: Bool, topicUserName: String, isStartGame: Bool, isShowResult: Bool) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, isBombAppear: isBombAppear, topicUserName: topicUserName, isStartGame: isStartGame, isShowResult: isShowResult)
        return encode(gameData: gameData)
    }
    
    func encode(playReaction: Bool, isKingjungReaction: Bool, reactionScore: Int, allKingjungScore: Int, allEvaScore: Int) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, isPlayingReaction: playReaction, isKingjungReaction: isKingjungReaction, reactionScore: reactionScore, allKingjuncScore: allKingjungScore, allEvaScore: allEvaScore)
        return encode(gameData: gameData)
    }
    
    func encode(playerName: String, myKingjungScore: Int, myEvaScore: Int) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, myKingjungScore: myKingjungScore, myEvaScore: myEvaScore)
        return encode(gameData: gameData)
    }
    
    func encode(outcome: String) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, outcome: outcome)
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
    
    //햅틱부분
    func encode(wasSuccessCalledHaptics: Bool) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, wasSuccessCalledHaptics: wasSuccessCalledHaptics)
        return encode(gameData: gameData)
    }
    
    func encode(wasErrorCalledHaptics: Bool) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, wasErrorCalledHaptics: wasErrorCalledHaptics)
        return encode(gameData: gameData)
    }
    //햅틱부분
    
    func decode(matchData: Data) -> GameData? {
        return try? PropertyListDecoder().decode(GameData.self, from: matchData)
    }
    
    // QuestionStart
    func encode(isStartQuestion: Bool) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, isStartQuestion: isStartQuestion)
        return encode(gameData: gameData)
    }
    
    func encode(isShowingBeginQuestionModal: Bool) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, isShowingBeginQuestionModal: isShowingBeginQuestionModal)
        return encode(gameData: gameData)
    }
}
