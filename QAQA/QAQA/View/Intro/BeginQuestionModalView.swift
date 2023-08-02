//
//  BeginQuestionModalView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/30.
//

import SwiftUI

struct BeginQuestionModalView: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var game: RealTimeGame

    
    
    var body: some View {
        VStack(spacing: 0){
            Spacer()
                .frame(height: 22)
            Text("질문 폭격")
                .font(.custom("BMJUAOTF", size: 14))
                .foregroundColor(.gray)
            Spacer()
                .frame(height: 5)
            HStack{
                Image(systemName: "alarm.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .foregroundColor(.outroGaugeGreen)
                Text("10분")
                    .font(.custom("BMJUAOTF", size: 30))
                    .foregroundColor(.outroGaugeGreen)
            }
            Spacer()
                .frame(height: 9)
            Image("beginQuestionModalQaqa")
                .resizable()
                .scaledToFit()
                .frame(width: 162)
            Spacer()
                .frame(height: 9)
            Group {
                Text("이제 \(game.topicUserName)에게 질문폭격을 해볼 차례에요! 준비됐나요?")
                    .font(.custom("BMJUAOTF", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 200)
                    .lineSpacing(5)
                Spacer()
                    .frame(height: 13)
                Text("소리와 함께 하면 더 즐겁게 즐길 수 있어요!")
                    .font(.custom("BMJUAOTF", size: 15))
                    .foregroundColor(.outroViewLightGray)
                    .multilineTextAlignment(.center)
                    .frame(width: 288)
                Spacer()
                    .frame(height: 24)
            }
            Button {
                game.isStartQuestion.toggle()
                game.startQuestion()
            } label: {
                Image("startButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 358)
            }
        }
    }
}

struct BeginQuestionModalView_Previews: PreviewProvider {
    static var previews: some View {
        BeginQuestionModalView(game: RealTimeGame())
    }
}
