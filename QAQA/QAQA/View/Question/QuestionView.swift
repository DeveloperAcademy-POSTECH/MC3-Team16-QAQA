//
//  QuestionView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import SwiftUI

struct QuestionView: View {
    //    @EnvironmentObject var timerModel: TimerModel
    @EnvironmentObject var gameTimerModel: RealTimeGame
    @ObservedObject var game: RealTimeGame
    @State private var showHintModal = false
    //    @State var showTimerModal = false
    @State var showFinishModal = false
    @State var isShowingOutroView = false
    
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                    .frame(width: 16)
                HStack{
                    Spacer()
                        .frame(width: 20)
                    Button {
                        game.isTimer.toggle()
                        game.showTimerModal = true  // action
                        game.timerModalController()
                    } label: {
                        Image(systemName: "pause.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Circle().foregroundColor(.pauseButtonYellow))
                    }
                    .sheet(isPresented: $game.showTimerModal){
                        TimerModalView(gameTimerModel: _gameTimerModel, game: RealTimeGame())
                            .presentationDetents([.height(257)])
                            .presentationCornerRadius(32)
                            .padding(.top, 30)
                            .onAppear{
                                gameTimerModel.isTimer.toggle()
                            }
                            .onDisappear{
                                gameTimerModel.isTimer.toggle()
                                //                                game.showTimerModal = false
                                game.timerModalController()
                                print("\(game.showTimerModal)")
                                
                            }
                    }
                    TimerView(game: game, isShowingOutroView: $isShowingOutroView, width:100)
                        .environmentObject(gameTimerModel)
                    Spacer()
                        .frame(width: 130)
                    Button{
                        showFinishModal.toggle()
                    } label: {
                        Image("endButton_Yellow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                    }
                    .sheet(isPresented: $showFinishModal, content: {
                        FinishModalView(isShowingOutroView: $isShowingOutroView, game: game) //TODO: View 바꾸기
                            .presentationDetents([.height(257)])
                            .presentationCornerRadius(32)
                            .padding(.top, 44)
                            .padding([.leading, .trailing], 16)
                            .onAppear{
                                game.isTimer.toggle()
                            }
                            .onDisappear{
                                game.isTimer.toggle()
                            }
                    })
                    Spacer()
                        .frame(width: 16)
                } //Timer와 끝내기 버튼
                ZStack{ //QuestionView의 메인 내용과 ReactionView를 ZStack으로 쌓아놓기
                    VStack (spacing: 0) { //QuestionView의 메인 내용(프로필과 질문버튼, 리액션버튼)
                        Group {
                            Spacer()
                                .frame(height: 10)
                            ZStack{
                                Image("questionBubble")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 211)
                                VStack{
                                    Text("오늘의 주인공")
                                        .font(.custom("BMJUAOTF", size: 15))
                                    Text("\(game.topicUserName)")
                                        .font(.custom("BMJUAOTF", size: 20))
                                    Spacer()
                                        .frame(height: 15)
                                }
                            }
                            Image("questionQaqa")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140)
                            HintView()
                            Spacer()
                                .frame(height: 30)
                        }
                    }
                  
                        //ReactionView
                        ReactionView(game: RealTimeGame(),isReaction: $game.playReaction, reactionState: self.$game.isGoodReaction)
                            .opacity(game.playReaction ? 1 : 0)
        
                }
                
                HStack{
                    Button(action: { //reaaction button action
                        game.isGoodReaction = true // 킹정
                        withAnimation(.spring(response: 0.2, blendDuration: 0.0)){
                            game.playReaction.toggle()
                            game.pushGoodReaction()
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
                            withAnimation(.default){
                                game.playReaction.toggle()
                                game.pushGoodReaction()
                            }
                        })
                    }, label: { //킹정버튼
                        VStack(alignment:.center){
                            Image("reactionButton_Good")
                                .resizable()
                                .frame(width: 153, height: 138)
                                .padding(.trailing ,10)
                            //                                            Text("킹정")
                            //                                                .font(.custom("BMJUAOTF", size: 20))
                            //                                                .foregroundColor(Color("reactionGoodColor"))
                            //                                                .bold()
                            //                                                .padding(.trailing, 15)
                        }
                    })
                    Button(action: {
                        game.isGoodReaction = false
                        withAnimation(.spring(response: 0.2, blendDuration: 0.0)){
                            game.playReaction.toggle()
                            game.pushGoodReaction()
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
                            withAnimation(.default){
                                game.playReaction.toggle()
                                game.pushGoodReaction()
                            }
                        })//에바버튼 액션
                    }, label: { //에바버튼
                        VStack(alignment:.center){
                            Image("reactionButton_Bad")
                                .resizable()
                                .frame(width: 153, height: 138)
                                .padding(.leading ,10)
                            //                                            Text("에바")
                            //                                                .font(.custom("BMJUAOTF", size: 20))
                            //                                                .foregroundColor(Color("reactionQuestionColor"))
                            //                                                .bold()
                            //                                                .padding(.leading, 15)
                        }
                    })
                }
                
            }
            .onAppear {
                game.topicUserName = game.topicUserName // TODO: 안됨
            }
            if (game.gameIsEnd) {
                OutroEndingView(game: game,  isShowingOutroView: $isShowingOutroView)
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(game:RealTimeGame())
            .environmentObject(RealTimeGame())
    }
}
