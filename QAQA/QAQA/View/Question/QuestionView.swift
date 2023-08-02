//
//  QuestionView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import SwiftUI

struct QuestionView: View {
    @StateObject private var reactionSoundViewModel = ReactionSoundViewModel()
    @EnvironmentObject var gameTimerModel: RealTimeGame
    @ObservedObject var game: RealTimeGame
    
    @State private var showHintModal = false
    @State var showFinishModal = false
    @State var isShowingOutroView = false
    @Binding var isShowingQuestionView : Bool
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 16)
                HStack {
                    Button {
                        game.showTimerModal = true
                        game.isTimer.toggle()
                        game.timerModalController()
                    } label: {
                        Image(systemName: "pause.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Circle().foregroundColor(.pauseButtonYellow))
                    }
                    TimerView(game: game, isShowingOutroView: $isShowingOutroView)
                        .environmentObject(gameTimerModel)
                        .padding([.leading], 14)
                    Spacer()
                    Button{
                        showFinishModal.toggle()
                    } label: {
                        Image("endButton_Yellow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 77)
                    }
                    .sheet(isPresented: $showFinishModal, content: {
                        FinishModalView(isShowingOutroView: $isShowingOutroView, game: game)
                            .presentationDetents([.height(257)])
                            .onAppear{
                                game.isTimer.toggle()
                            }
                            .onDisappear{
                                game.isTimer.toggle()
                            }
                    })
                } //Timer와 끝내기 버튼
                .padding([.leading, .trailing], 15)
                ZStack{ //QuestionView의 메인 내용과 ReactionView를 ZStack으로 쌓아놓기
                    VStack (spacing: 0) {
                        Spacer()
                        HintView(game: game)
                        Spacer()
                    }
                    //ReactionView
                    ReactionView(game: game,isReaction: $game.playReaction, isKingjungReaction: self.$game.isKingjungReaction)
                        .opacity(game.playReaction ? 1 : 0)
                }
                HStack { // Reaction Buttons
                    Button(action: { // 킹정버튼
                        if !game.playReaction {
                            reactionSoundViewModel.playSound(sound: reactionSoundViewModel.createRandomKingjungReactionSounds())
                            game.isKingjungReaction = true // 킹정
                            game.allKingjungScore += 1
                            game.reactionScore += 1
                            game.myKingjungScore += 1
                            withAnimation(
                                .default
                            ){
                                game.playReaction = true
                                game.pushReaction()
                                game.callSuccessHaptics()
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
                            withAnimation(.default){
                                game.playReaction.toggle()
                                game.pushReaction()
                            }
                        })
                    }, label: {
                        VStack(alignment:.center){
                            Image("reactionButton_Good")
                                .scaledToFill()
                        }
                    })
                    Spacer()
                    Button(action: { // 에바 버튼
                        if !game.playReaction {
                            reactionSoundViewModel.playSound(sound: reactionSoundViewModel.createRandomEvaReactionSounds())
                            game.isKingjungReaction = false
                            game.allEvaScore += 1
                            game.reactionScore += 1
                            game.myEvaScore += 1
                            withAnimation(
                                .default
                            ){
                                game.playReaction = true
                                game.pushReaction()
                                game.callErrorHaptics()
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
                            withAnimation(.default){
                                game.playReaction.toggle()
                                game.pushReaction()
                            }
                        })
                    }, label: {
                        VStack(alignment:.center) {
                            Image("reactionButton_Bad")
                                .scaledToFill()
                        }
                    })
                }
                .padding([.leading, .trailing], 37)
                .padding([.bottom], 24)
            }
            if (game.gameIsEnd) {
                OutroEndingView(game: game, isShowingOutroView: $isShowingOutroView)
            } else if (game.showTimerModal) {
                TimerModalView()
                    .onTapGesture {
                        game.showTimerModal = false
                        game.isTimer = true
                        game.timerModalController()
                    }
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(game:RealTimeGame(), isShowingQuestionView: .constant(false))
    }
}
