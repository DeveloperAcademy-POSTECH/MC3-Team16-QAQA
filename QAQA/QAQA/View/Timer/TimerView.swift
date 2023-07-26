//
//  TimerView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import SwiftUI

struct TimerView: View {
//    @EnvironmentObject var timerModel: TimerModel
    @EnvironmentObject var gameTimerModel: RealTimeGame
    @ObservedObject var game: RealTimeGame
    @Binding var isShowingOutroView: Bool
    @State var width:CGFloat = 150
    @State var height:CGFloat = 50
    @State var timerSizeMultiplier:CGFloat = 1

    
    var body: some View {
        ZStack{
            VStack(spacing: 10 * timerSizeMultiplier){
                Text(gameTimerModel.displayTime(true))
                    .font(.custom("BMJUAOTF", size: 30 * timerSizeMultiplier))
                    .frame(width: width * timerSizeMultiplier, height: height * timerSizeMultiplier)
                    .foregroundColor(.black)
                    .onChange(of: gameTimerModel.countSecond, perform: { _ in
                        if (gameTimerModel.countMin == 0) && (gameTimerModel.countSecond == 0) {
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
        TimerView( game: RealTimeGame(), isShowingOutroView: QuestionView(game: RealTimeGame()).$isShowingOutroView)
            .environmentObject(RealTimeGame())
           
    }
}



