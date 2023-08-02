//
//  RealTimeGame+GKMatchDelegate.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import Foundation
import GameKit
import SwiftUI

extension RealTimeGame: GKMatchDelegate {
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        switch state {
        case .connected:
            print("\(player.displayName) Connected")
            if match.expectedPlayerCount == 0 {
                opponent = match.players[0]
            }
        case .disconnected:
            print("\(player.displayName) Disconnected")
        default:
            print("\(player.displayName) Connection Unknown")
        }
    }
    
    func match(_ match: GKMatch, didFailWithError error: Error?) {
        print("\n\nMatch object fails with error: \(error!.localizedDescription)")
    }
    
    func match(_ match: GKMatch, shouldReinviteDisconnectedPlayer player: GKPlayer) -> Bool {
        return false
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        let gameData = decode(matchData: data)
        
        if (gameData?.outcome) != nil {
            gameIsEnd = true
        } else if let reaction = gameData?.isPlayingReaction, let reactionState = gameData?.isKingjungReaction, let allReactionScore = gameData?.reactionScore, let kingjungScore = gameData?.allKingjuncScore, let evaScore = gameData?.allEvaScore {
            withAnimation(
                .default
            ){
                playReaction = reaction
                isKingjungReaction = reactionState
                reactionScore = allReactionScore
                allKingjungScore = kingjungScore
                allEvaScore = evaScore
            }
        } else if let timerModal = gameData?.showTimerModal, let timer = gameData?.isTimer {
            showTimerModal = timerModal
            isTimer = timer
        } else if let min = gameData?.countMin, let second = gameData?.countSecond {
            countMin = min
            countSecond = second
        } else if let playerName = gameData?.playerName, let playerKingjungScore = gameData?.myKingjungScore, let playerEvaScore = gameData?.myEvaScore {
            reactionScoreList.append((playerName, playerKingjungScore, playerEvaScore))
            kingjungKing = reactionScoreList.sorted(by: { $0.1 > $1.1 }).first?.0 ?? "None"
            evaKing = reactionScoreList.sorted(by: { $0.2 > $1.2 }).first?.0 ?? "None"
        } else if let bomb = gameData?.isBombAppear, let randomUserName = gameData?.topicUserName, let startGame = gameData?.isStartGame, let showResult = gameData?.isShowResult, let showCount = gameData?.isShowCount {
            isBombAppear = bomb
            topicUserName = randomUserName
            isStartGame = startGame
            isShowResult = showResult
            isShowCount = showCount
        }
        else if let wasSuccessCalled = gameData?.wasSuccessCalledHaptics, wasSuccessCalled { // 햅틱
            triggerSuccessHaptic()
        } else if let wasErrorCalled = gameData?.wasErrorCalledHaptics, wasErrorCalled {
            triggerErrorHaptic()
        }
        else if let questionStart = gameData?.isStartQuestion {
            withAnimation(.spring(response: 0.2,dampingFraction: 0.25,blendDuration: 0.0)){
                isStartQuestion = questionStart
            }
        }
        else if let questionStartModal = gameData?.isShowingBeginQuestionModal {
            withAnimation(.spring(response: 0.2,dampingFraction: 0.25,blendDuration: 0.0)){
                isShowingBeginQuestionModal = questionStartModal
            }
        }
            
            if allEvaScore == 0 {
                evaKing = "-"
            }
            if allKingjungScore == 0 {
                kingjungKing = "-"
            }
    }
       
        
        func triggerSuccessHaptic() {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        
        func triggerErrorHaptic() {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
        //햅틱부분
}
