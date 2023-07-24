//
//  RealTimeGame.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import Foundation
import GameKit
import SwiftUI

/// - Tag:RealTimeGame
@MainActor
class RealTimeGame: NSObject, GKGameCenterControllerDelegate, ObservableObject {
    
    // The local player's friends, if they grant access.
    @Published var friends: [Friend] = []
    
    // The game interface state.
    @Published var matchAvailable = false
    @Published var playingGame = false
    @Published var myMatch: GKMatch? = nil
    @Published var automatch = false
    
    // Outcomes of the game for notifing players.
    @Published var gameIsEnd = false
//    @Published var opponentForfeit = false
//    @Published var youWon = false
//    @Published var opponentWon = false
    
    // The match information.
    @Published var myAvatar = Image(systemName: "person.crop.circle")
    @Published var opponentAvatar = Image(systemName: "person.crop.circle")
    @Published var opponent: GKPlayer? = nil
    @Published var myScore = 0
    @Published var opponentScore = 0
    
    // TopicUser
    @Published var topicUser: GKPlayer? = nil
    @Published var topicUserAvatar = Image(systemName: "person.crop.circle")
    
    // The voice chat properties.
    @Published var voiceChat: GKVoiceChat? = nil
    @Published var opponentSpeaking = false

    // 타이머 모델 변수
    @Published var countMin = 10
    @Published var countSecond = 0
    @Published var isTimer = true
    @Published var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
//    @Published var
    func displayTime(_ isCount:Bool = true) -> some View{ //아규먼트 값이 true면은 카운트가 되는 시간이고(TimerView에 적용) false면은 단순히 TimerModel에서 변수만 받아와서 시간만 표기하는 함수(TimerModalView에 적용), .onReceive를 실행하는냐 아니냐의 차이
        if isCount == true {
            if countSecond < 10 {
                return  Text("\(self.countMin):0\(countSecond)")
                    .onReceive(timer , perform: {(_) in
//                        print("\(self.countMin), \(self.countSecond)")
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
//                        print("\(self.countMin), \(self.countSecond)")
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
    
    /// The name of the match.
    var matchName: String {
        "\(opponentName) Match"
    }
    
    /// The local player's name.
    var myName: String {
        GKLocalPlayer.local.displayName
    }
    
    /// The opponent's name.
    var opponentName: String {
        opponent?.displayName ?? "Invitation Pending"
    }
    
    /// The topicUser's name.
    var topicUserName: String {
        topicUser?.displayName ?? "None"
    }
    
    /// The root view controller of the window.
    var rootViewController: UIViewController? { // root View Controller
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }

    /// Authenticates the local player, initiates a multiplayer game, and adds the access point.
    /// - Tag:authenticatePlayer
    func authenticatePlayer() {
        // Set the authentication handler that GameKit invokes.
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // If the view controller is non-nil, present it to the player so they can
                // perform some necessary action to complete authentication.
                self.rootViewController?.present(viewController, animated: true) { }
                return
            }
            if let error {
                // If you can’t authenticate the player, disable Game Center features in your game.
                print("Error: \(error.localizedDescription).")
                return
            }
            
            // A value of nil for viewController indicates successful authentication, and you can access
            // local player properties.
            
            // Load the local player's avatar.
            GKLocalPlayer.local.loadPhoto(for: GKPlayer.PhotoSize.small) { image, error in
                if let image {
                    self.myAvatar = Image(uiImage: image)
                }
                if let error {
                    // Handle an error if it occurs.
                    print("Error: \(error.localizedDescription).")
                }
            }

            // Register for real-time invitations from other players.
            GKLocalPlayer.local.register(self)
            
            // Add an access point to the interface.
            GKAccessPoint.shared.location = .topTrailing
            GKAccessPoint.shared.showHighlights = true
            GKAccessPoint.shared.isActive = true
            
            // Enable the Start Game button.
            self.matchAvailable = true
        }
    }
    
    /// Starts the matchmaking process where GameKit finds a player for the match.
    /// - Tag:findPlayer
    func findPlayer() async { // 플레이어 찾는 함수
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 6
        let match: GKMatch
        
        // Start automatch.
        do {
            match = try await GKMatchmaker.shared().findMatch(for: request)
        } catch {
            print("Error: \(error.localizedDescription).")
            return
        }

        // Start the game, although the automatch player hasn't connected yet.
        if !playingGame {
            startMyMatchWith(match: match)
        }

        // Stop automatch.
        GKMatchmaker.shared().finishMatchmaking(for: match)
        automatch = false
    }
    
    /// Presents the matchmaker interface where the local player selects and sends an invitation to another player.
    /// - Tag:choosePlayer
    func choosePlayer() { // 플레이어 선택하는 함수
        // Create a match request.
        let request = GKMatchRequest() // real-time or turn-based match를 위한 파라미터들을 캡슐화한 object
        request.minPlayers = 2 // 최소, 최대 플레이어 수 지정 (여기서 지정해줘야함)
        request.maxPlayers = 6
        
        // Present the interface where the player selects opponents and starts the game.
        // GKMatchmakerViewController는 플레이어가 상대를 선택하고, 게임을 시작하는 인터페이스를 보여줍니다.
        // 위에서 만든 request 를 이 뷰컨트롤러에 전달합니다.
        if let viewController = GKMatchmakerViewController(matchRequest: request) {
            viewController.matchmakerDelegate = self // 딜리게이트 설정
            rootViewController?.present(viewController, animated: true) { } // animated true로 해서, rootViewController에 게임뷰컨트롤러를 전달합니다.
        }
    }
    
    // 게임 시작과 끝내는 부분
    
    // 게임 시작!!
    // match는 리얼타임매치를 나타내는 object입니다.
    /// - Tag:startMyMatchWith
    func startMyMatchWith(match: GKMatch) {
        createRandomTopicUser() // TODO: 랜덤생성 함수 위치 변경 예정
        GKAccessPoint.shared.isActive = false // TODO: ??
        playingGame = true // playingGame 부울값을 true로
        myMatch = match // myMatch는 GKMatch를 전달
        myMatch?.delegate = self
        
        // 오토매치일 때, 아바타를 로드하기 전에 상대가 매치에 연결되었는지를 확인합니다.
        if myMatch?.expectedPlayerCount == 0 { // 초대받은 플레이어가 모두 연결된 경우
            opponent = myMatch?.players[0] // 내 매치의 0번째 플레이어를 opponent로 둡니다. - 임의로 두는 것임.. 스코어 기록하려면 이거 구조를 아예 바꿔줘야할 듯??
            
            // 상대방의 아바타를 로드합니다.
            opponent?.loadPhoto(for: GKPlayer.PhotoSize.small) { (image, error) in
                if let image {
                    self.opponentAvatar = Image(uiImage: image)
                }
                if let error {
                    print("Error: \(error.localizedDescription).")
                }
            }
        }
            
        // Increment the achievement to play 10 games.
        reportProgress()
    }
    
    /// Takes the player's turn.
    /// - Tag:takeAction
    func takeAction() {
        // Take your turn by incrementing the counter.
        // 차례대로 counter 를 증가시킵니다.
        myScore += 1
        
        // 점수가 10점 이상이거나 최고점에 도달하면 게임에서 이기게 됩니다.
        if (myScore - opponentScore == 10) || (myScore == 100) {
//            endMatch()
            return
        }
        
        // 그렇지 않으면 다른 플레이어에게 게임 데이터를 전송합니다.
        do {
            let data = encode(score: myScore)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    /// Quits a match and saves the game data.
    /// - Tag:endMatch
    func endMatch() {
        let myOutcome = myScore >= opponentScore ? "won" : "lost"
        let opponentOutcome = opponentScore > myScore ? "won" : "lost"

        // Notify the opponent that they won or lost, depending on the score.
        do {
            let data = encode(outcome: opponentOutcome) // TODO: - Encode가 뭐하는 애임??
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }

//        // Notify the local player that they won or lost.
//        if myOutcome == "won" {
//            youWon = true
//        } else {
//            opponentWon = true
//        }
        gameIsEnd = true
    }

    /// Saves the local player's score.
    /// - Tag:saveScore
    func saveScore() {
        GKLeaderboard.submitScore(myScore, context: 0, player: GKLocalPlayer.local,
            leaderboardIDs: ["123"]) { error in
            if let error {
                print("Error: \(error.localizedDescription).")
            }
        }
    }

//    /// Resets a match after players reach an outcome or cancel the game.
    func resetMatch() {
        // Reset the game data.
        playingGame = false
        myMatch?.disconnect()
        myMatch?.delegate = nil
        myMatch = nil
        voiceChat = nil
        opponent = nil
        opponentAvatar = Image(systemName: "person.crop.circle")
        GKAccessPoint.shared.isActive = true
        gameIsEnd = false
//        opponentForfeit = false
//        youWon = false
//        opponentWon = false

        // Reset the score.
        myScore = 0
        opponentScore = 0
    }

    // Rewarding players with achievements.

    // 로컬 플레이어의 성과를 보고하는 함수입니다.
    func reportProgress() {
        GKAchievement.loadAchievements(completionHandler: { (achievements: [GKAchievement]?, error: Error?) in
            let achievementID = "1234" // achievementID를 임의로 생성해줍니다.
            var achievement: GKAchievement? = nil

            // 존재하는 성과를 찾는 코드입니다.
            achievement = achievements?.first(where: { $0.identifier == achievementID })

            // 존재하지 않으면, 새로운 achievement를 생성합니다.
            if achievement == nil {
                achievement = GKAchievement(identifier: achievementID)
            }

            // Create an array containing the achievement.
            let achievementsToReport: [GKAchievement] = [achievement!]

            // 플레이어가 달성한 성과를 나타내는 백분율 값입니다.
            achievement?.percentComplete = achievement!.percentComplete + 10.0

            // 게임센터에 프로그레스를 보고합니다.
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
    
    func createRandomTopicUser() {
        topicUser = myMatch?.players.randomElement() // 이 함수 실행시킨 뒤에 이름, 프로필 불러오면 됨
        
        topicUser?.loadPhoto(for: GKPlayer.PhotoSize.small) { (image, error) in
            if let image {
                self.topicUserAvatar = Image(uiImage: image)
            }
            if let error {
                print("Error: \(error.localizedDescription).")
            }
        }
    }
}

