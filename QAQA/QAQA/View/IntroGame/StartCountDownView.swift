//
//  StartCountDownView.swift
//  QAQA
//
//  Created by 김기영 on 2023/08/01.
//

import SwiftUI

struct StartCountDownView: View {
    @ObservedObject var game: RealTimeGame
    
   
    var body: some View {
        ZStack{
            Image("countDownBackground")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("웜홀에 폭탄을 넣어\n다른 팀원에게 던지세요")
                    .foregroundColor(.black)
                    .font(.custom("BMJUAOTF", size: 25))
                    .lineSpacing(10)
                    .multilineTextAlignment(.center)
                Text("\(game.countSecond)")
                    .font(.custom("BMJUAOTF", size: 150))
                    .foregroundColor(.white)
                    .padding(.top, 42)
                    .onReceive(game.timer, perform: { _ in
                        if game.countSecond > 0 && game.isTimer {
                            game.countSecond -= 1
                        } else if game.countSecond == 0 {
                            game.isShowCount = false 
                        }
                    })
            }
        }//zstack 끝
        .sheet(isPresented: $game.isStartGame, content: {
            BeginIntroModalView(game:game)
                .presentationDetents([.height(511)])
                .onAppear(){
                    game.countSecond = 3
                    game.isTimer = false
                }
                .onDisappear(){
                    game.isStartGame = false
                    game.bombTransport()
                    game.isTimer = true
                    game.timerNumberCount()
                }
        })
    }
}

struct StartCountDownView_Previews: PreviewProvider {
    static var previews: some View {
        StartCountDownView(game: RealTimeGame())
    }
}
