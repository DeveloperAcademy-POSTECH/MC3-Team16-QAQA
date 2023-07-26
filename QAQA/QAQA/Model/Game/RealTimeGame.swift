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
    @Published var isGoodReaction = false

    @Published var myAvatar = Image(systemName: "person.crop.circle")
    @Published var opponent: GKPlayer? = nil
    @Published var myScore = 0
    @Published var opponentScore = 0
    
    // TopicUser
    @Published var topicUserName: String = "TopicUserName"


    // 타이머 모델 변수
    @Published var countMin = 10
    @Published var countSecond = 0
    @Published var showTimerModal = false
    @Published var isTimer = true
    @Published var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

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

    func takeAction() {
        myScore += 1
        
        if (myScore - opponentScore == 10) || (myScore == 100) {
//            endMatch()
            return
        }
        
        do {
            let data = encode(score: myScore)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
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
    
    func pushGoodReaction() {
        do {
            let data = encode(playReaction: playReaction, isGoodReaction: isGoodReaction)
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
    
    func displayTime(_ isCount:Bool = true) -> some View{ //아규먼트 값이 true면은 카운트가 되는 시간이고(TimerView에 적용) false면은 단순히 TimerModel에서 변수만 받아와서 시간만 표기하는 함수(TimerModalView에 적용), .onReceive를 실행하는냐 아니냐의 차이
        if isCount == true { // TODO: 코드 수정
            if countSecond < 10 {
                return  Text("\(self.countMin):0\(countSecond)")
                    .onReceive(timer , perform: {(_) in
                        if self.isTimer {
                            if self.countSecond == 0 {
                                if self.countMin == 0 {
                                    self.isTimer = false
                                    self.endMatch()
                                    self.reportProgress()
                                    return
                                }
                                self.countMin -= 1
                                self.countSecond = 59
                            }
                            else {
                                self.countSecond -= 1
                            }
                        }
                    })
            }
            else
            {
                return  Text("\(countMin):\(countSecond)")
                    .onReceive(timer , perform: {(_) in
                        if self.isTimer {
                            if self.countSecond == 0 {
                                if self.countMin == 0 {
                                    self.isTimer = false
                                    self.endMatch()
                                    self.reportProgress()
                                    return
                                }
                                self.countMin -= 1
                                self.countSecond = 59
                            }
                            else {
                                self.countSecond -= 1
                            }
                        }
                    })
            }
        } else {
            if countSecond < 10 {
                return  Text("\(self.countMin):0\(countSecond)")
                    .onReceive(timer , perform: { _ in })
            }
            else
            {
                return  Text("\(countMin):\(countSecond)")
                    .onReceive(timer , perform: { _ in })
            }
        }
    }
}

