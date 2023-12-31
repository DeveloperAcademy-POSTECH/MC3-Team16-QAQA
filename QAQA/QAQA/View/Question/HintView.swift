//
//  HintModal.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/12.
//

import SwiftUI

struct HintView: View {
    @StateObject private var hintViewModel = HintViewModel()
    @ObservedObject var game: RealTimeGame
    @State private var selectedHint: HintState = .getToKnow
    @State private var questionText = "질문 뽑기 버튼을 눌러보세요!"
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image("questionBubble")
                    .resizable()
                    .scaledToFit()
                    .padding([.leading, .trailing], 90)
                VStack{
                    Text("오늘의 주인공")
                        .font(.custom("BMJUAOTF", size: 15))
                    Text("\(game.topicUserName)")
                        .font(.custom("BMJUAOTF", size: 20))
                        .padding([.bottom], 15)
                }
            }
            Image("questionQaqa")
                .resizable()
                .scaledToFit()
                .padding([.leading, .trailing], 125)
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.hintViewYellow)
                VStack(spacing: 0) {
                    Text("궁금한 질문을 골라보세요!")
                        .font(.custom("BMJUAOTF", size: 15))
                        .foregroundColor(.hintViewOrange)
                        .padding([.top], 25)
                        .padding([.bottom], 16)
                    Picker("HintMode", selection: $selectedHint) {
                        Text("알아가기").tag(HintState.getToKnow)
                        Text("재미").tag(HintState.fun)
                        Text("진지").tag(HintState.serious)
                    }
                    .padding([.leading, .trailing], 47)
                    .pickerStyle(.segmented)
                    .onChange(of: selectedHint, perform: { _ in
                        createRandomQuestion()
                    })
                    Spacer()
                    Text("\(questionText)")
                        .font(.custom("BMJUAOTF", size: 25))
                        .padding([.leading, .trailing], 19)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .lineSpacing(7)
                    Spacer()
                    Button {
                        createRandomQuestion()
                    } label: {
                        Image("randomHintButton")
                            .resizable()
                            .scaledToFit()
                            .padding([.leading, .trailing], 68)
                    }
                    Spacer()
                        .frame(height: 25)
                }
            }
            .frame(height: 332)
            .padding([.leading, .trailing], 16)
        }
    }
}

extension HintView {
    func createRandomQuestion() {
        switch selectedHint {
        case .getToKnow :
            questionText = hintViewModel.createRandomGetToKnowHints()
        case .fun :
            questionText = hintViewModel.createRandomFunHints()
        case .serious :
            questionText = hintViewModel.createRandomSeriousHints()
        }
    }
}


struct HintModal_Previews: PreviewProvider {
    static var previews: some View {
        HintView(game: RealTimeGame())
    }
}
