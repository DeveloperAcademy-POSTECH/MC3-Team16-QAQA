//
//  TimerModalView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import SwiftUI

struct TimerModalView: View {
//    @EnvironmentObject var timerModel: TimerModel
//    @EnvironmentObject var gameTimerModel: RealTimeGame
//    @ObservedObject var game: RealTimeGame
//    @Environment(\.presentationMode) var presentation
//    @State var timeContainerWidth:CGFloat = 250
//    @State var paddingHeight:CGFloat = 10
//    @State var restartButtonColor: Color = Color.blue.opacity(0.8)
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.6)
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Text("잠깐 정지!")
                    .font(.custom("BMJUAOTF", size: 40))
                    .foregroundColor(.white)
                Spacer()
                    .frame(height: 5)
                Text("터치 시 재개됩니다")
                    .font(.custom("BMJUAOTF", size: 23))
                    .foregroundColor(.white)
                Image("pauseQaqa")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 322)
            }
        }
    }
}

struct TimerModalView_Previews: PreviewProvider {
    static var previews: some View {
        TimerModalView()
    }
}

