//
//  TimerModalView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import SwiftUI

struct TimerModalView: View {
    @EnvironmentObject var timerModel: TimerModel
    @State var timeContainerWidth = UIScreen.width * 0.31
    @State var paddingHeight = UIScreen.height * 0.04
    @State var restartButtonColor: Color = Color.blue.opacity(0.8)
    var body: some View {
        VStack(alignment: .center){
            if timerModel.countSecond < 10 {
                Text("\(timerModel.countMin):0\(timerModel.countSecond)").font(.system(size: 45).bold())
                    .foregroundColor(.black)
                    .frame(width: timeContainerWidth)
                    .padding(.bottom)
                        .frame(height: paddingHeight)
            }
            else {
                Text("\(timerModel.countMin):\(timerModel.countSecond)").font(.system(size: 45).bold())
                    .foregroundColor(.black)
                    .frame(width: timeContainerWidth)
                    .padding(.bottom)
                        .frame(height: paddingHeight)
            }
            Text("일시정지")
                .frame(width: timeContainerWidth)
                .padding(.bottom, paddingHeight * 1.3)
                    
            Button(action: {}, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(restartButtonColor)
                        .frame(width: UIScreen.width * 0.8, height: UIScreen.height * 0.07)
                    Text("재개하기")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
            })
            .padding(.bottom,paddingHeight * 0.3)
            Button(action: {}, label: {
                Text("종료하기").foregroundColor(restartButtonColor) // 종료하기를 누르면 어디로 가는지?
            })
        }
        .onAppear{
            timerModel.isTimer.toggle()
        }
    }
}

struct TimerModalView_Previews: PreviewProvider {
    static var previews: some View {
        TimerModalView()
            .environmentObject(TimerModel())
    }
}

