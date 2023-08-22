//
//  TimerView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import SwiftUI

struct TimerView: View {
//    @EnvironmentObject var timerModel: TimerModel
//    @EnvironmentObject var game: RealTimeGame
    @ObservedObject var game: RealTimeGame
    @Binding var isShowingOutroView: Bool
    @State var fontSize = 30.0

    
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Text((game.countSecond < 10) ? "\(game.countMin):0\(game.countSecond)" : "\(game.countMin):\(game.countSecond)")
                    .font(.custom("BMJUAOTF", size: fontSize))
                    .foregroundColor(.black)
                    .onReceive(game.timer, perform: { _ in
                        if game.isTimer {
                            game.displayTime()
                            game.timerModalController()
                            game.timerNumberCount()
                        }
                    })
                    .onChange(of: game.countSecond, perform: { _ in
                        if (game.countMin == 0) && (game.countSecond == 0) {
                            isShowingOutroView.toggle()
                            game.endMatch()
                            game.reportProgress() // -> gameIsEnd가 true 됨
                        }
                    })
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView( game: RealTimeGame(), isShowingOutroView: .constant(false))
//            .environmentObject(RealTimeGame())
           
    }
}



//TimerView(gameTimerModel: _gameTimerModel, game: RealTimeGame(), isShowingOutroView: QuestionView(game: game).$isShowingOutroView,width: 250 , fontSize: 70)
