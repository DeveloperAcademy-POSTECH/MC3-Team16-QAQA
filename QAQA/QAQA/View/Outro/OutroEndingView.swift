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
    @State private var userName = "웃쾌마" //오늘의 주인공 username
    @State private var reactionNum = 24
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Group {
                    Spacer()
                        .frame(height: 61)
                    Text("\(userName)")
                        .font(.custom("BMJUAOTF", size: 40))
                        .foregroundColor(.outroViewYellow)
                    Spacer()
                        .frame(height: 10)
                    Text("오늘 받은 반응이에요!")
                        .font(.custom("BMJUAOTF", size: 17))
                        .foregroundColor(.outroViewGray)
                    Spacer()
                        .frame(height: 21)
                    Image("outroQaqa")
                        .resizable()
                        .frame(width: 318, height: 284)
                    Spacer()
                        .frame(height: 20)
                }
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 358, height: 40)
                    .foregroundColor(.outroViewGaugeGray)
                Spacer()
                    .frame(height: 23)
                OutroResultCardView()
                Spacer()
                    .frame(height: 53)
                
                //                ScrollView(.horizontal, showsIndicators: false) {
                //                    makeCardViews()
                //                    // TODO: 자동 스크롤 효과
                //                }
                
                Button {
                    game.resetMatch()
                    game.saveScore()
                    isShowingOutroView.toggle()
                } label: {
                    Image("backToHomeButton_Yellow")
                        .resizable()
                        .frame(width: 358, height: 53)
                }
                
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
