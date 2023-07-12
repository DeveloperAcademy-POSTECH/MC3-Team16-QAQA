//
//  TestView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/10.
//

import SwiftUI
import GameKit

struct TestView: View {
    @StateObject private var game = RealTimeGame()
    
    var body: some View {
        VStack {
            Button("Choose Player") { // 플레이어 선택 -> 초대, SharePlay가 존재함
                if game.automatch {
                    // Turn automatch off.
                    GKMatchmaker.shared().cancel()
                    game.automatch = false
                }
                game.choosePlayer()
            }
        }
        .padding()
        .onAppear {
            if !game.playingGame {
                game.authenticatePlayer()
            }
        }
        // Display the game interface if a match is ongoing.
        .fullScreenCover(isPresented: $game.playingGame) {
            GameView(game: game)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
