//
//  TestingIntroGame.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/29.
//

import SwiftUI

struct TestingIntroGame: View {
    @ObservedObject var game: RealTimeGame
//    @State var isBombPresent = false
    
    var body: some View {
        ZStack{
            if game.isBombPresent {
                Image("boom_1")
                    .resizable()
                    .frame(width:150, height:150)
            }
            VStack{
                Text("\(game.topicUserName)")
                Spacer()
                Button {
                    game.createRandomTopicUser(match: game.myMatch!, isMyNameExclude: true)
                    game.isBombAppear.toggle()
                    game.bombTransport()
                } label: {
                    Text("Send bomb")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 50))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 300, height: 70)
                        )
                }
                Spacer().frame(height: 30)
            }
        }
        .onChange(of: game.isBombAppear, perform: { _ in
            if game.myName == game.topicUserName {
                game.isBombPresent = true
            } else {
                game.isBombPresent = false
            }
        })
    }
}

struct TestingIntroGame_Previews: PreviewProvider {
    static var previews: some View {
        TestingIntroGame(game:RealTimeGame())
    }
}
