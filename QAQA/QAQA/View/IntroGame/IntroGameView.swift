//
//  IntroGameView.swift
//  QAQA
//
//  Created by 김기영 on 2023/08/01.
//

import SwiftUI

struct IntroGameView: View {
    @ObservedObject var game: RealTimeGame
    @ObservedObject var gyroscopeMAnager: GyroscopeManager
    var body: some View {
        ZStack{
            Image("countDownBackground")
                .resizable()
                .ignoresSafeArea()
            VStack{
                
                VStack{
                    Text("미니 게임")
                        .font(.custom("BMJUAOTF", size: 25))
                        .foregroundColor(.gray)
                    HStack{
                        Image(systemName: "alarm.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .foregroundColor(.outroGaugeGreen)
                        Text("1분")
                            .font(.custom("BMJUAOTF", size: 30))
                            .foregroundColor(.outroGaugeGreen)
                    }
                    .padding(10)
                    Text("폭탄 돌리기 게임으로\n질문 받을 사람을 정해요!")
                        .font(.custom("BMJUAOTF", size: 35))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 350)
                        .lineSpacing(10)
                        .padding(.bottom, 10)
                }
                
                Button{
                    game.createRandomTopicUser(match: game.myMatch!)
                    game.isStartGame.toggle()
                    game.bombTransport()
                    if game.myName == game.topicUserName {
                        game.isBombPresent = true
                    } else {
                        game.isBombPresent = false
                    }
                    game.bombTransport()
                } label: {
                    Image("startButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 358)
                        .padding(.top,400)
                }
            }

            if game.isStartGame ==  false {
                BallContainerView(game: game, gyroscopeManager: GyroscopeManager())
            }
            
            
//            BallContainerView(game: game, gyroscopeManager: gyroscopeMAnager)
//                .onAppear(){
////                    game.createRandomTopicUser(match: game.myMatch!)
////                    game.bombTransport()
////                    if game.myName == game.topicUserName {
////                        game.isBombPresent = true
////                    } else {
////                        game.isBombPresent = false
////                    }
//                    }
            
        }
    }
}

//struct IntroGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        IntroGameView(game: RealTimeGame(), gyroscopeMAnager: GyroscopeManager())
//    }
//}
