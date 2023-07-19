//
//  TimerView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timerModel: TimerModel
    @State var width:CGFloat = 150
    @State var height:CGFloat = 50
    @State var timerSizeMultiplier:CGFloat = 1
    
    var body: some View {
        ZStack{
            VStack(spacing: 10 * timerSizeMultiplier){
                timerModel.displayTime()
                    .font(.system(size: 30 * timerSizeMultiplier).bold())
                    .frame(width: width * timerSizeMultiplier, height: height * timerSizeMultiplier)
                    .foregroundColor(.black)
                
            }

        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(TimerModel())
           
    }
}



