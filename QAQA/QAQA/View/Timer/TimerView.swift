//
//  TimerView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import SwiftUI

struct TimerView: View {
//    @EnvironmentObject var timerModel: TimerModel
    @EnvironmentObject var game: RealTimeGame
    @Binding var isShowingOutroView: Bool
    @State var width:CGFloat = 150
    @State var height:CGFloat = 50
    @State var timerSizeMultiplier:CGFloat = 1
    
    var body: some View {
        ZStack{
            VStack(spacing: 10 * timerSizeMultiplier){
                game.displayTime()
                    .font(.system(size: 30 * timerSizeMultiplier).bold())
                    .frame(width: width * timerSizeMultiplier, height: height * timerSizeMultiplier)
                    .foregroundColor(.black)
                    .onReceive(game.timer, perform: {
                        _ in
                        print("\(game.countMin)")
                        if (game.countMin == 0) && (game.countSecond == 0){
                            print("ssfe")
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
        TimerView( isShowingOutroView: QuestionView(game: RealTimeGame()).$isShowingOutroView)
            .environmentObject(RealTimeGame())
           
    }
}



