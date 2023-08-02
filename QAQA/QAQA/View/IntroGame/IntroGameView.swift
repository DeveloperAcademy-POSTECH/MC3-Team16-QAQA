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
            BallContainerView(game: game, gyroscopeManager: gyroscopeMAnager)
                .onAppear(){
//                    game.createRandomTopicUser(match: game.myMatch!)
//                    game.bombTransport()
//                    if game.myName == game.topicUserName {
//                        game.isBombPresent = true
//                    } else {
//                        game.isBombPresent = false
//                    }
                    }
                
                
            if game.isShowCount {
                StartCountDownView(game: game)
            
            }
        }
    }
}

//struct IntroGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        IntroGameView(game: RealTimeGame(), gyroscopeMAnager: GyroscopeManager())
//    }
//}
