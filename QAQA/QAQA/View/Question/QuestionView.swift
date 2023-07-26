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
    @State var isReaction = false //리액션뷰를 온오프하는 변수
    @State var reactionState = false //킹정인지 에바인지 구분하는 변수
    
    @State private var userName = "UserName"
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
                        timerModel.isTimer.toggle()
                        showTimerModal = true// action
                    } label: {
                        Image(systemName: "pause.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Circle().foregroundColor(Color("pauseButtonYellow")))
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
                    TimerView(width: 80)
                    Spacer()
                        .frame(width: 130)
                    Button{
                        showFinishModal.toggle()
                    } label: {
                        Image("endButton")
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
                    VStack (spacing: 0) { //QuestionView의 메인 내용(프로필과 질문버튼, 리액션버튼)
                        Group {
                            ZStack{
                                Image("questionBubble")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 211)
                                VStack{
                                    Text("오늘의 주인공")
                                        .font(.custom("BMJUAOTF", size: 15))
                                    Text("\(userName)")
                                        .font(.custom("BMJUAOTF", size: 25))
                                    Spacer()
                                        .frame(height: 10)
                                }
                            }
                              Image("questionQaqa")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140)
                                HintView()
                            Spacer()
                                .frame(height: 30)
                                HStack{
                                    Button(action: { //reaaction button action
                                        reactionState = true
                                        withAnimation(.spring(response: 0.2,dampingFraction: 0.25,blendDuration: 0.0)){
                                            isReaction.toggle()
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
                                            withAnimation(.default){
                                                isReaction.toggle()
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
                                        reactionState = false
                                        withAnimation(.spring(response: 0.2,dampingFraction: 0.25,blendDuration: 0.0)){
                                            isReaction.toggle()
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
                                            withAnimation(.default){
                                                isReaction.toggle()
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
                    }
                    //ReactionView
                    ReactionView(game: RealTimeGame(),isReaction: self.$isReaction, reactionState: self.$reactionState)
                        .opacity(isReaction ? 1 : 0)
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
