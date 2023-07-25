//
//  QuestionView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var timerModel: TimerModel
    @ObservedObject var game: RealTimeGame
    @State private var showHintModal = false
    @State var showTimerModal = false
    @State var showFinishModal = false
    @State private var userName = "UserName"
    @State var isShowingOutroView = false
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Spacer()
                        .frame(width: 16)
                    Button {
                        timerModel.isTimer.toggle()
                        showTimerModal = true// action
                    } label: {
                        Image(systemName: "pause.fill" )
                            .foregroundColor(Color("pauseTextColor"))
                            .padding(15)
                            .background(Circle().foregroundColor(Color("pauseButtonColor")))
                    }
                    .sheet(isPresented: $showTimerModal){
                        TimerModalView()
                            .presentationDetents([.height(257)])
                            .presentationCornerRadius(32)
                            .padding(.top, 30)
                            .onDisappear{
                                timerModel.isTimer.toggle()
                            }
                    }
                    TimerView(width:100)
                    Spacer()
                    Button{
                        showFinishModal.toggle()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(Color("finishButtonColor"))
                                .frame(width: 77, height: 44)
                            Text("끝내기")
                                .foregroundColor(.red)
                                .bold()
                        }
                    }
                    .sheet(isPresented: $showFinishModal, content: {
                        FinishModalView(isShowingOutroView: $isShowingOutroView, game: game) //TODO: View 바꾸기
                            .presentationDetents([.height(257)])
                            .presentationCornerRadius(32)
                            .padding(.top, 44)
                            .padding([.leading, .trailing], 16)
                            .onAppear{
                                timerModel.isTimer.toggle()
                            }
                            .onDisappear{
                                timerModel.isTimer.toggle()
                            }
                    })
                    Spacer()
                        .frame(width: 16)
                } //Timer와 끝내기 버튼
                ZStack{ //QuestionView의 메인 내용과 ReactionView를 ZStack으로 쌓아놓기
                    VStack{ //QuestionView의 메인 내용(프로필과 질문버튼, 리액션버튼)
                        Group{
                            Spacer()
                                .frame(height: 10)
                            Text("\(userName)")
                                .font(.system(size: 24, weight: .bold))
                            Spacer()
                                .frame(height: 24)
                            ZStack{
                                RoundedRectangle(cornerRadius: 40)
                                    .foregroundColor(.gray.opacity(0.1))
                                    .frame(width: 361, height: 400)
                                HintView()
                            }
                            Spacer()
                                .frame(height: 30)
                            ZStack{
                                RoundedRectangle(cornerRadius: 103)
                                    .foregroundColor(.gray.opacity(0.1))
                                    .frame(width: 393, height: 206)
                                HStack{
                                    Button(action: { //reaaction button action
                                        game.isGoodReaction = true // 킹정
                                        withAnimation(.spring(response: 0.2,dampingFraction: 0.25,blendDuration: 0.0)){
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
                                            ZStack{
                                                Image("greenButton")
                                                    .resizable()
                                                    .frame(width: 153, height: 138)
                                                    .padding(.trailing ,10)
                                                Image("star")
                                                    .resizable()
                                                    .frame(width:64, height: 61)
                                                    .padding(.trailing,10)
                                                    .padding(.bottom, 15)
                                            }
                                            Text("킹정")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color("reactionGoodColor"))
                                                .bold()
                                                .padding(.trailing, 15)
                                        }
                                    })
                                    Button(action: {
                                        game.isGoodReaction = false
                                        withAnimation(.spring(response: 0.2,dampingFraction: 0.25,blendDuration: 0.0)){
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
                                            ZStack{
                                                Image("orangeButton")
                                                    .resizable()
                                                    .frame(width: 153, height: 138)
                                                    .padding(.leading ,10)
                                                Image("questionMark")
                                                    .resizable()
                                                    .frame(width:64, height: 61)
                                                    .padding(.leading,10)
                                                    .padding(.bottom, 15)
                                            }
                                            Text("에바")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color("reactionQuestionColor"))
                                                .bold()
                                                .padding(.leading, 15)
                                        }
                                    })
                                }
                            }
                        }
                    }
                    //ReactionView
                    ReactionView(game: RealTimeGame(),isReaction: $game.playReaction, reactionState: self.$game.isGoodReaction)
                        .opacity(                                            game.playReaction ? 1 : 0)
                }
            }
            .onAppear {
                userName = game.topicUserName // TODO: 안됨
            }
            if (game.gameIsEnd) {
                OutroEndingView(game: game,  isShowingOutroView: $isShowingOutroView)
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(game: RealTimeGame())
            .environmentObject(TimerModel())
    }
}
