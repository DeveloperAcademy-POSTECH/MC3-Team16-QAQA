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
    
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Button(action: {isTimer.toggle()}, label: {  ZStack{
                    Circle().foregroundColor(.blue.opacity(0.15))
                        .frame(width: UIScreen.width * 0.13)
                    Image(systemName: isTimer ? "pause.fill" : "play.fill")
                        .font(.system(size: UIScreen.width * 0.06))
                        .foregroundColor(.blue.opacity(0.8))
                }})
                
                if countSecond < 10 {
                    Text("\(countMin):0\(countSecond)").font(.system(size: 45).bold()).frame(width: timeContainerWidth)
                }
                else {
                    Text("\(countMin):\(countSecond)").font(.system(size: 45).bold()).frame(width: timeContainerWidth)
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



