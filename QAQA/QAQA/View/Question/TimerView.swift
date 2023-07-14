//
//  TimerView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timerModel: TimerModel
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @State var countMin = 10
//    @State var countSecond = 0
//    @State var isTimer = false
    @State var circleBackgroundColor: Color = Color.blue.opacity(0.15)
    @State var playPauseColor: Color = Color.blue.opacity(0.8)
    @State var width:CGFloat = 150
    @State var height:CGFloat = 50
    @State var timerSizeMultiplier:CGFloat = 1
    
    var body: some View {
        ZStack{
            VStack(spacing: 10 * timerSizeMultiplier){
//                Button(action: {timerModel.isTimer.toggle()}, label: {  ZStack{
//                    Circle().foregroundColor(circleBackgroundColor)
//                        .frame(width: UIScreen.width * 0.13 * timerSizeMultiplier)
//                    Image(systemName: timerModel.isTimer ? "pause.fill" : "play.fill")
//                        .font(.system(size: UIScreen.width * 0.06 * timerSizeMultiplier))
//                        .foregroundColor(playPauseColor)
//                }})
                
                if timerModel.countSecond < 10 {
                    Text("\(timerModel.countMin):0\(timerModel.countSecond)").font(.system(size: 45 * timerSizeMultiplier).bold()).frame(width: width * timerSizeMultiplier, height: height * timerSizeMultiplier)
                        .foregroundColor(.black)
                }
                else {
                    Text("\(timerModel.countMin):\(timerModel.countSecond)").font(.system(size: 45 * timerSizeMultiplier).bold()).frame(width: width * timerSizeMultiplier, height: height * timerSizeMultiplier)
                        .foregroundColor(.black)
                }
                
            }
            .onReceive(timer , perform: {(_) in
                if timerModel.isTimer {
                    if timerModel.countSecond == 0 {
                        if timerModel.countMin == 0 {
                            timerModel.isTimer = false
                            return
                        }
                        timerModel.countMin -= 1
                        timerModel.countSecond = 59
                    }
                    else {
                        timerModel.countSecond -= 1
                    }
                }
            })
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(TimerModel())
    }
}



