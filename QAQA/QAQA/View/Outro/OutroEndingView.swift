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
    @State var animateGaugeBar = false
    
    @State private var isShowingInfoView = true
    //    @State private var reactionNum = 24
    
    
    private let duration = 1.0
    @State var isAnimated = false
    @State var defaultKingjungWidth = 30.0
    @State var defaultEvaWidth = 30.0
    @State var defaultSpacerWidth = 300.0
    
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
                        .foregroundColor(.outroGaugeGray)
                    HStack {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: defaultKingjungWidth, height: 40, alignment: .leading)
                                .foregroundColor(.outroGaugeYellow)
                            VStack (alignment: .leading){
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: (defaultKingjungWidth-20), height: 8, alignment: .leading)
                                    .foregroundColor(.outroGaugeLightYellow)
                                Spacer()
                                    .frame(height: 15)
                            }
                        }
                        Spacer()
                            .frame(width: defaultSpacerWidth)
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: defaultEvaWidth, height: 40, alignment: .leading)
                                .foregroundColor(.outroGaugeGreen)
                            VStack (alignment: .leading){
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: (defaultEvaWidth-20), height: 8, alignment: .leading)
                                    .foregroundColor(.outroGaugeLightGreen)
                                Spacer()
                                    .frame(height: 15)
                            }
                        }
                    }
                } .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        isAnimated.toggle()
                        withAnimation(.easeOut(duration: duration)){
                            defaultKingjungWidth = outroEndingViewModel.calculateKingjungWidth()
                        }
                        withAnimation(.easeOut(duration: duration)){
                            defaultEvaWidth = outroEndingViewModel.calculateEvaWidth()
                        }
                        withAnimation(.easeOut(duration: duration)){
                            defaultSpacerWidth = outroEndingViewModel.calculateSpacerWidth()
                        }
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
     
    }
    
    struct OutroEndingView_Previews: PreviewProvider {
        static var previews: some View {
            OutroEndingView(game: RealTimeGame(), isShowingOutroView: .constant(false))
        }
    }
}
