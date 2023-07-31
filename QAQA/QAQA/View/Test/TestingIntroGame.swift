//
//  TestingIntroGame.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/29.
//

import SwiftUI

struct TestingIntroGame: View {
    @ObservedObject var game: RealTimeGame
    @State var isExplode = false
    @State var isShowExplodedName = false
    @State var isShowResult = false
//    @State var isBombPresent = false
    
    var body: some View {
        ZStack{
            ZStack{
                
                Image(isExplode ? "boom_2" : "boom_1")
                    .resizable()
                    .frame(width:150, height:150)
                    .opacity(game.isBombPresent ? 1 : 0)
                VStack{
                    Text("\(game.topicUserName)")
                    Text(game.isBombPresent ? "true" : "false")
                    Text(isExplode ? "걸려부렸다~~~" : "")
                    Text(isShowExplodedName ? "걸린 사람은? \(game.topicUserName)":"")
                    Spacer()
                    Button {
                        game.createRandomTopicUser(match: game.myMatch!, isMyNameExcluded: true)
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
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.0, execute: {
                    if game.isBombAppear {
                        isExplode.toggle()
                        game.bombTransport()
                    } else {
                        isShowExplodedName.toggle()
                    }
                })
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6.0, execute: {
                    isShowResult.toggle()
                })
            }
            if isShowResult {
                TestingResultView(game: game)
            }
        }
        
    }
}

struct TestingIntroGame_Previews: PreviewProvider {
    static var previews: some View {
        TestingIntroGame(game:RealTimeGame())
    }
}
