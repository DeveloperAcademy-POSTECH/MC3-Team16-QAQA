//
//  OutroEndingView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/16.
//

import SwiftUI

struct OutroEndingView: View {
    @StateObject private var outroViewModel = OutroViewModel()
    @ObservedObject var game: RealTimeGame
    
    @Binding var isShowingOutroView: Bool
    
    @State private var isShowingInfoView = true
    @State private var userName = "웃쾌마"
    @State private var reactionNum = 24
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Spacer()
                    .frame(height: 63)
                Text("\(userName) 님이")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                Spacer()
                    .frame(height: 16)
                Text("\(reactionNum)")
                    .font(.system(size: 80))
                    .fontWeight(.bold)
                Spacer()
                    .frame(height: 8)
                Text("개의 반응을 받았어요!")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    makeCardViews()
                    // TODO: 자동 스크롤 효과
                }
                Spacer()
                    .frame(height: 10)
                Button {
                    game.resetMatch()
                    game.saveScore()
                    isShowingOutroView.toggle()
                } label: {
                    Text("수고하셨습니다!")
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 20)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 16))
                }.padding(.bottom, 16)
                    .padding([.leading, .trailing], 16)
                
            }
            if (isShowingInfoView) { // TODO: animation
                OutroInfoView()
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            isShowingInfoView.toggle()
                        }
                    }
            }
        }
    }
}

extension OutroEndingView {
    private func makeCardViews() -> some View {
        HStack {
            ForEach(outroViewModel.cardModels) { model in
                OutroCardView(text: model.cardText, profile: model.cardProfile, username: model.cardUserName, isShowingCrown: model.isShowingCrown)
                    .padding(.trailing, 20)
            }
        }
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 70)
    }
}

struct OutroEndingView_Previews: PreviewProvider {
    static var previews: some View {
        OutroEndingView(game: RealTimeGame(), isShowingOutroView: .constant(false))
    }
}
