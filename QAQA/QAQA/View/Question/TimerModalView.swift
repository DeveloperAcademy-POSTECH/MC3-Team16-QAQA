//
//  TimerModalView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import SwiftUI

struct TimerModalView: View {
    @EnvironmentObject var timerModel: TimerModel
    @Environment(\.presentationMode) var presentation
    @State var timeContainerWidth:CGFloat = 250
    @State var paddingHeight:CGFloat = 10
    @State var restartButtonColor: Color = Color.blue.opacity(0.8)
    var body: some View {
        VStack(alignment: .center){
            timerModel.displayTime(false)
                .font(.system(size: 70))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: timeContainerWidth)
                .padding(.bottom, paddingHeight)
            Text("일시정지")
                .frame(width: timeContainerWidth)
                .padding(.bottom, 20)
            
            Button(action: {
                timerModel.isTimer.toggle()
                presentation.wrappedValue.dismiss()
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(restartButtonColor)
                        .frame(width: 361, height: 60)
                    Text("재개하기")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
            })
            .padding(.bottom,paddingHeight * 0.3)
        }
        
    }
}

struct TimerModalView_Previews: PreviewProvider {
    static var previews: some View {
        TimerModalView()
            .environmentObject(TimerModel())
    }
}

