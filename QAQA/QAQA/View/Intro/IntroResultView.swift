//
//  IntroResultView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/29.
//

import SwiftUI

struct IntroResultView: View {
    
    @ObservedObject var game: RealTimeGame
    @State var showBeginQuestionModal = false
    @State var isShowingQuestionView = false
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 0){
                Spacer()
                    .frame(height: 148)
                ZStack{
                    Image("questionBubble")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 255)
                    VStack{
                        Text("오늘의 주인공")
                            .font(.custom("BMJUAOTF", size: 16))
                        Spacer()
                            .frame(height: 5)
                        Text("\(game.topicUserName)")
                            .font(.custom("BMJUAOTF", size: 28))
                        Spacer()
                            .frame(height: 15)
                    }
                }
                Image("introResultQaqa")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 202)
                Spacer()
                    .frame(height: 159)
                Button{
                    showBeginQuestionModal.toggle()
                } label: {
                    Image("nextButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 358)
                }
                .sheet(isPresented: $showBeginQuestionModal, content: {
                    BeginQuestionModalView(game: game, isShowingQuestionView: $isShowingQuestionView)
                        .presentationDetents([.medium])
                        .presentationCornerRadius(20)
                })
            }
            if isShowingQuestionView == true {
                QuestionView(game: game, isShowingQuestionView: $isShowingQuestionView)
            }
        }
    }

}

struct IntroResultView_Previews: PreviewProvider {
    static var previews: some View {
        IntroResultView(game:RealTimeGame())
    }
}
