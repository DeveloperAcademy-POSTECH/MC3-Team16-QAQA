//
//  OutroEndingView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/16.
//

import SwiftUI

struct OutroEndingView: View {
    @StateObject private var outroEndingViewModel = OutroEndingViewModel()
    @StateObject private var outroViewModel = OutroViewModel()
    @ObservedObject var game: RealTimeGame
    
    @Binding var isShowingOutroView: Bool
    
    @State private var isShowingInfoView = true
    @State private var reactionNum = 24
//    @State private var totalKingjung: CGFloat = 10
//    @State private var totalEva: CGFloat = 10
//    @Binding var totalReaction: Int
    
//    @State private var kingjungWidth: CGFloat = 0
    //  = CGFloat((totalKingjung/totalReaction)*360
//    @State private var evaWidth: CGFloat = 0
    // = CGFloat((totalEva/totalReaction)*360
    
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Group {
                    Spacer()
                        .frame(height: 40)
                    Text("\(game.topicUserName)")
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
                ZStack (alignment: .leading){
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 360, height: 40)
                        .foregroundColor(.outroViewGaugeGray)
                    HStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: outroEndingViewModel.calculateKingjungWidth(), height: 40, alignment: .leading)
                            .foregroundColor(.yellow)
                        Spacer()
                            .frame(width: outroEndingViewModel.calculateSpacerWidth())
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: outroEndingViewModel.calculateEvaWidth(), height: 40)
//                            .frame(width: CGFloat((totalEva/totalReaction)*360), height: 40)
                            .foregroundColor(.green)
                    }
                }
                Spacer()
                    .frame(height: 23)
                OutroResultCardView()
                Spacer()
                    .frame(height: 73)
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
//        .onAppear {
//            kingjungWidth = CGFloat((totalKingjung/totalReaction)*360)
//            evaWidth = CGFloat((totalEva/totalReaction)*360)
//        }
    }
}

struct OutroEndingView_Previews: PreviewProvider {
    static var previews: some View {
        OutroEndingView(game: RealTimeGame(), isShowingOutroView: .constant(false))
    }
}
