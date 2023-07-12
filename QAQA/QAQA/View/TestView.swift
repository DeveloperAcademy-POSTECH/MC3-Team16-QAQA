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
            Spacer()
            Button { // 플레이어 선택 -> 플레이어 초대, 오토매칭
                if game.automatch {
                    // Turn automatch off.
                    GKMatchmaker.shared().cancel()
                    game.automatch = false
                }
                game.choosePlayer()
            } label: {
                Text("시작하기")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.testWhite.opacity(0.5))
                    .cornerRadius(16)
            }
            .padding([.leading,.trailing], 16)
            Spacer()
                .frame(height: 62)
        }
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
