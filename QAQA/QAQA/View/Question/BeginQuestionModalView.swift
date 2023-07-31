//
//  BeginQuestionModalView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/30.
//

import SwiftUI

struct BeginQuestionModalView: View {
    
    @ObservedObject var game: RealTimeGame
    
    var body: some View {
        VStack{
            Text("질문 폭격")
            HStack{
                Image(systemName: "alarm.fill")
                Text("10분")
            }
            Image("beginQuestionModalQaqa")
            Text("이제 \(game.topicUserName)에게 질문폭격을 해볼 차례에요! 준비됐나요?")
            Text("소리와 함께 하면 더 즐겁게 즐길 수 있어요!")
            Image("startButton")
        }
    }
}

struct BeginQuestionModalView_Previews: PreviewProvider {
    static var previews: some View {
        BeginQuestionModalView(game:RealTimeGame())
    }
}
