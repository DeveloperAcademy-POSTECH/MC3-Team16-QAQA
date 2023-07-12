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
    @Published var youForfeit = false
    @Published var opponentForfeit = false
    @Published var youWon = false
    @Published var opponentWon = false
    
    // The match information.
    @Published var myAvatar = Image(systemName: "person.crop.circle")
    @Published var opponentAvatar = Image(systemName: "person.crop.circle")
    @Published var opponent: GKPlayer? = nil
    @Published var myScore = 0
    @Published var opponentScore = 0
    
    // The voice chat properties.
    @Published var voiceChat: GKVoiceChat? = nil
    @Published var opponentSpeaking = false
    
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
            GKAccessPoint.shared.location = .topLeading
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
    
    // Starting and stopping the game.
    // 게임 시작과 끝내는 부분
    
    // 게임 시작!!
    /// Starts a match.
    /// - Parameter match: The object that represents the real-time match.
    // match는 리얼타임매치를 나타내는 object.
    /// - Tag:startMyMatchWith
    func startMyMatchWith(match: GKMatch) {
        GKAccessPoint.shared.isActive = false // TODO: ??
        playingGame = true // playingGame 부울값을 true로
        myMatch = match // myMatch는 GKMatch를 전달
        myMatch?.delegate = self
        
        // For automatch, check whether the opponent connected to the match before loading the avatar.
        // 오토매치
        if myMatch?.expectedPlayerCount == 0 { // 예상 참여 Player
            opponent = myMatch?.players[0]
            
            // Load the opponent's avatar.
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
//        reportProgress()
    }
    
    /// Takes the player's turn.
    /// - Tag:takeAction
    func takeAction() {
        // Take your turn by incrementing the counter.
        myScore += 1
        
        // If your score is 10 points higher or reaches the maximum, you win the match.
        if (myScore - opponentScore == 10) || (myScore == 100) {
//            endMatch()
            return
        }
        
        // Otherwise, send the game data to the other player.
//        do {
//            let data = encode(score: myScore)
//            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
//        } catch {
//            print("Error: \(error.localizedDescription).")
//        }
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

        // Notify the local player that they won or lost.
        if myOutcome == "won" {
            youWon = true
        } else {
            opponentWon = true
        }
    }
//
//    /// Forfeits a match without saving the score.
//    /// - Tag:forfeitMatch
//    func forfeitMatch() {
//        // Notify the opponent that you forfeit the game.
//        do {
//            let data = encode(outcome: "forfeit")
//            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
//        } catch {
//            print("Error: \(error.localizedDescription).")
//        }
//
//        youForfeit = true
//    }
//
//    /// Saves the local player's score.
//    /// - Tag:saveScore
//    func saveScore() {
//        GKLeaderboard.submitScore(myScore, context: 0, player: GKLocalPlayer.local,
//            leaderboardIDs: ["123"]) { error in
//            if let error {
//                print("Error: \(error.localizedDescription).")
//            }
//        }
//    }
//
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
//        messages = []
        GKAccessPoint.shared.isActive = true
        youForfeit = false
        opponentForfeit = false
        youWon = false
        opponentWon = false

        // Reset the score.
        myScore = 0
        opponentScore = 0
    }
//
//    // Rewarding players with achievements.
//
//    /// Reports the local player's progress toward an achievement.
//    // 로컬 플레이어의 성과를 보고하는 함수입니다.
//    func reportProgress() {
//        GKAchievement.loadAchievements(completionHandler: { (achievements: [GKAchievement]?, error: Error?) in
//            let achievementID = "1234"
//            var achievement: GKAchievement? = nil
//
//            // 존재하는 성과를 찾는 코드입니다.
//            // Find an existing achievement.
//            achievement = achievements?.first(where: { $0.identifier == achievementID })
//
//            // Otherwise, create a new achievement.
//            if achievement == nil {
//                achievement = GKAchievement(identifier: achievementID)
//            }
//
//            // Create an array containing the achievement.
//            let achievementsToReport: [GKAchievement] = [achievement!]
//
//            // Set the progress for the achievement.
//            achievement?.percentComplete = achievement!.percentComplete + 10.0
//
//            // Report the progress to Game Center.
//            // 게임센터에 프로그레스를 보고합니다.
//            GKAchievement.report(achievementsToReport, withCompletionHandler: {(error: Error?) in
//                if let error {
//                    print("Error: \(error.localizedDescription).")
//                }
//            })
//
//            if let error {
//                print("Error: \(error.localizedDescription).")
//            }
//        })
//    }
}

