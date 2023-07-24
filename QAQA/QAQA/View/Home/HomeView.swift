//
//  TestView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/10.
//

import SwiftUI
import GameKit

struct HomeView: View {
    @StateObject private var game = RealTimeGame()
    @EnvironmentObject var gameTimerModel: RealTimeGame
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading) {
                    Spacer()
                        .frame(height: 30)
                    Text("QAQA")
                        .font(.system(size: 42))
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    Text("팀 온보딩을 위한 10분 질문폭격!")
                        .foregroundColor(.gray)
                }
                .padding(.leading, 16)
                Spacer()
            }
            Spacer()
                .frame(height: 66)
            Image("homeQuokka")
            Spacer()
            Button { // 플레이어 선택 -> 플레이어 초대, 오토매칭
                if game.automatch { // TODO: 이거 없어도 되는건가??
                    // Turn automatch off.
                    GKMatchmaker.shared().cancel()
                    game.automatch = false
                }
                game.choosePlayer()
            } label: {
                Text("팀 찾기")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.testBlue)
                    .cornerRadius(16)
            }
            .padding([.leading,.trailing], 16)
            Spacer()
                .frame(height: 18)
        }
        .onAppear {
            if !game.playingGame {
                game.authenticatePlayer()
            }
        }
        // Display the game interface if a match is ongoing.
        .fullScreenCover(isPresented: $game.playingGame) {
            QuestionView(game:game)
                .onAppear(){
                    gameTimerModel.countMin = 10
                    gameTimerModel.countSecond = 0
                    gameTimerModel.isTimer = true
                }
                
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RealTimeGame())
    }
}
