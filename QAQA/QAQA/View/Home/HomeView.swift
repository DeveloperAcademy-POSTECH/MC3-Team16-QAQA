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
    //    @Binding var isShowingHomeView : Bool
    
    
    var body: some View {
        
        ZStack {
            Color(red: 1, green: 0.8, blue: 0.3)
                .ignoresSafeArea()
            
            
            
            Image("homeViewImg")
                .resizable()
                .scaledToFit()
                .padding(.top, 50)
            
            
            VStack {
                Spacer()
                Button {
                    // 플레이어 선택 -> 플레이어 초대, 오토매칭
                    if game.automatch {
                        // Turn automatch off.
                        GKMatchmaker.shared().cancel()
                        game.automatch = false
                    }
                    game.choosePlayer()
                } label: {
                    ZStack {
                        Image("homeViewButton_Green")
                        Text("시작하기")
                            .font(.custom("BMJUAOTF", size: 17))
                            .foregroundColor(.black)
                            .padding(.bottom, 5)
                    }
                }
                .padding(54)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            if !game.playingGame {
                game.authenticatePlayer()
            }
        }
        // Display the game interface if a match is ongoing.
        .fullScreenCover(isPresented: $game.playingGame) {
//            IntroResultView(game:game)
//                .onAppear(){
//                    gameTimerModel.countMin = 10
//                    gameTimerModel.countSecond = 0
//                    gameTimerModel.isTimer = true
//                }
            //            TestingIntroGame(game: game)
                        IntroGameView(game: game, gyroscopeMAnager: GyroscopeManager())
            
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RealTimeGame())
    }
}
