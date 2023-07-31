//
//  RealTimeGame.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import Foundation
import GameKit
import SwiftUI

@MainActor
class RealTimeGame: NSObject, GKGameCenterControllerDelegate, ObservableObject {

    @Published var friends: [Friend] = []

    @Published var matchAvailable = false
    @Published var playingGame = false
    @Published var myMatch: GKMatch? = nil
    @Published var automatch = false
    
    // 공유될 변수
    @Published var gameIsEnd = false
    @Published var playReaction = false
    @Published var isKingjungReaction = false

    @Published var myAvatar = Image(systemName: "person.crop.circle")
    @Published var opponent: GKPlayer? = nil
    @Published var myScore = 0
    @Published var opponentScore = 0
    
    // TopicUser
    @Published var topicUserName: String = "TopicUserName"
    
    // Reaction Score
    @Published var reactionScore = 0
    @Published var allKingjungScore = 0
    @Published var allEvaScore = 0
    @Published var myKingjungScore = 0
    @Published var myEvaScore = 0
    @Published var reactionScoreList: [(String, Int, Int)] = [] // 이름, 킹정수, 에바수
    @Published var kingjungKing = ""
    @Published var evaKing = ""

    // 타이머 변수
    @Published var countMin = 10
    @Published var countSecond = 0
    @Published var showTimerModal = false
    @Published var isTimer = true
    @Published var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    //햅틱부분
    @Published var wasSuccessCalledHaptics = false // new field
    @Published var wasErrorCalledHaptics = false // new field
    //햅틱부분

    var matchName: String {
        "\(opponentName) Match"
    }

    var myName: String {
        GKLocalPlayer.local.displayName
    }

    var opponentName: String {
        opponent?.displayName ?? "Invitation Pending"
    }

    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }

    func authenticatePlayer() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                self.rootViewController?.present(viewController, animated: true) { }
                return
            }
            if let error {
                print("Error: \(error.localizedDescription).")
                return
            }
            
            GKLocalPlayer.local.loadPhoto(for: GKPlayer.PhotoSize.small) { image, error in
                if let image {
                    self.myAvatar = Image(uiImage: image)
                }
                if let error {
                    print("Error: \(error.localizedDescription).")
                }
            }

            GKLocalPlayer.local.register(self)
            
            GKAccessPoint.shared.location = .topTrailing
            GKAccessPoint.shared.showHighlights = true
            GKAccessPoint.shared.isActive = true

            self.matchAvailable = true
        }
    }
    
    func findPlayer() async {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 6
        let match: GKMatch
        
        do {
            match = try await GKMatchmaker.shared().findMatch(for: request)
        } catch {
            print("Error: \(error.localizedDescription).")
            return
        }

        if !playingGame {
            startMyMatchWith(match: match)
        }

        GKMatchmaker.shared().finishMatchmaking(for: match)
        automatch = false
    }
    
    func choosePlayer() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 6

        if let viewController = GKMatchmakerViewController(matchRequest: request) {
            viewController.matchmakerDelegate = self
            rootViewController?.present(viewController, animated: true) { }
        }
    }
    
    // 게임 시작과 끝내는 부분
    func startMyMatchWith(match: GKMatch) {
        GKAccessPoint.shared.isActive = false
        playingGame = true
        myMatch = match
        myMatch?.delegate = self
        
        if myMatch?.expectedPlayerCount == 0 {
            opponent = myMatch?.players[0]
            createRandomTopicUser(match: myMatch!)
        }
        reportProgress()
    }
    
    func endMatch() {
        let opponentOutcome = opponentScore > myScore ? "won" : "lost"

        do {
            let data = encode(outcome: opponentOutcome)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
        gameIsEnd = true
    }

    func saveScore() {
        GKLeaderboard.submitScore(myScore, context: 0, player: GKLocalPlayer.local,
            leaderboardIDs: ["123"]) { error in
            if let error {
                print("Error: \(error.localizedDescription).")
            }
        }
    }

    func resetMatch() {
        playingGame = false
        myMatch?.disconnect()
        myMatch?.delegate = nil
        myMatch = nil
        opponent = nil
        GKAccessPoint.shared.isActive = true
        gameIsEnd = false

        myScore = 0
        opponentScore = 0
        
        reactionScore = 0
        allKingjungScore = 0
        allEvaScore = 0
        myKingjungScore = 0
        myEvaScore = 0
        reactionScoreList = [] // 이름, 킹정수, 에바수
        
        // 리액션 수 및 다른 변수들 초기화
    }

    func reportProgress() {
        GKAchievement.loadAchievements(completionHandler: { (achievements: [GKAchievement]?, error: Error?) in
            let achievementID = "1234"
            var achievement: GKAchievement? = nil

            achievement = achievements?.first(where: { $0.identifier == achievementID })

            if achievement == nil {
                achievement = GKAchievement(identifier: achievementID)
            }

            let achievementsToReport: [GKAchievement] = [achievement!]

            achievement?.percentComplete = achievement!.percentComplete + 10.0

            GKAchievement.report(achievementsToReport, withCompletionHandler: {(error: Error?) in
                if let error {
                    print("Error: \(error.localizedDescription).")
                }
            })

            if let error {
                print("Error: \(error.localizedDescription).")
            }
        })
    }
    
    func createRandomTopicUser(match: GKMatch) {
        var allUserName: [String] = []
        for player in match.players {
            allUserName.append(player.displayName)
        }
        allUserName.append(myName)
        topicUserName = allUserName.randomElement()!
    }
    
    func pushReaction() {
        do {
            let data = encode(playReaction: playReaction, isKingjungReaction: isKingjungReaction, reactionScore: reactionScore, allKingjungScore: allKingjungScore, allEvaScore: allEvaScore)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    func rankReactionKing() {
        reactionScoreList.append((myName, myKingjungScore, myEvaScore))
        do {
            let data = encode(playerName: GKLocalPlayer.local.displayName, myKingjungScore: myKingjungScore, myEvaScore: myEvaScore)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    func timerModalController() {
        do {
            let data = encode(showTimerModal: showTimerModal, isTimer: isTimer)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    func timerNumberCount() {
        do {
            let data = encode(countMin: countMin, countSecond: countSecond)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    func displayTime() {
        if countSecond == 0 {
            if countMin == 0 {
                isTimer = false
                endMatch()
                reportProgress()
                return
            }
            countMin -= 1
            countSecond = 59
        }
        else {
            countSecond -= 1
        }
    }
    //햅틱부분
    func callSuccessHaptics() {
        do {
            let data = encode(wasSuccessCalledHaptics: true)
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }

    func callErrorHaptics() {
        do {
            let data = encode(wasErrorCalledHaptics: true)
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    //햅틱부분
}

