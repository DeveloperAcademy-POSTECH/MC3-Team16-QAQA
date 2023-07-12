//
//  TimerView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import SwiftUI

struct TimerView: View {
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var countMin = 10
    @State var countSecond = 0
    @State var isTimer = false
    @State var timeContainerWidth = UIScreen.width * 0.31
    @State var circleBackgroundColor: Color = Color.blue.opacity(0.15)
    @State var playPauseColor: Color = Color.blue.opacity(0.8)
    @State var timerSizeMultiplier:CGFloat = 1
    
    var body: some View {
        ZStack{
            VStack(spacing: 10 * timerSizeMultiplier){
                Button(action: {isTimer.toggle()}, label: {  ZStack{
                    Circle().foregroundColor(circleBackgroundColor)
                        .frame(width: UIScreen.width * 0.13 * timerSizeMultiplier)
                    Image(systemName: isTimer ? "pause.fill" : "play.fill")
                        .font(.system(size: UIScreen.width * 0.06 * timerSizeMultiplier))
                        .foregroundColor(playPauseColor)
                }})
                
                if countSecond < 10 {
                    Text("\(countMin):0\(countSecond)").font(.system(size: 45 * timerSizeMultiplier).bold()).frame(width: timeContainerWidth * timerSizeMultiplier)
                }
                else {
                    Text("\(countMin):\(countSecond)").font(.system(size: 45 * timerSizeMultiplier).bold()).frame(width: timeContainerWidth * timerSizeMultiplier)
                }
                
            }
            .onReceive(timer , perform: {(_) in
                if isTimer {
                    if countSecond == 0 {
                        if countMin == 0 {
                            isTimer.toggle()
                        }
                        countMin -= 1
                        countSecond = 59
                    }
                    else {
                        countSecond -= 1
                    }
                }
            })
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}



