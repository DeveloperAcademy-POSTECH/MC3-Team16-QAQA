//
//  TestIntroStartView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/31.
//

import SwiftUI

struct TestIntroStartView: View {
    @ObservedObject var game: RealTimeGame
//    @State var isStartGame = false
    var body: some View {
        ZStack{
            Button {
                game.createRandomTopicUser(match: game.myMatch!)
                game.isStartGame.toggle()
                game.bombTransport()
            } label: {
                Text("Start")
                    .foregroundColor(.white)
                    .background(
                        Rectangle()
                        .frame(width:250, height: 70)
                    )
            }
            if game.isStartGame{
                BallContainerView(game: game, gyroscopeManager: GyroscopeManager())
            }
            
          
        }

    }
}

struct TestIntroStartView_Previews: PreviewProvider {
    static var previews: some View {
        TestIntroStartView(game: RealTimeGame())
    }
}
