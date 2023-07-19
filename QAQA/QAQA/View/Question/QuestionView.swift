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
    @State var isReaction = false //리액션뷰를 온오프하는 변수
    @State var reactionState = false //킹정인지 에바인지 구분하는 변수
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                    .frame(width: 16)
                Button {
                    timerModel.isTimer.toggle()
                    showTimerModal = true// action
                } label: {
                    Image(systemName: "pause.fill" )
                        .foregroundColor(Color("pause"))
                        .padding(15)
                        .background(Circle().foregroundColor(Color("pauseButton")))
                }
                .sheet(isPresented: $showTimerModal){
                    TimerModalView()
                        .presentationDetents([.height(257)])
                        .presentationCornerRadius(32)
                        .padding(.top, 30)
                }
                TimerView(width:100)
                Spacer()
                Button(action: {
                    //끝내기 버튼 액션
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color("finishButton"))
                            .frame(width: 77, height: 44)
                        Text("끝내기")
                            .foregroundColor(.red)
                            .bold()
                    }
                })
                Spacer()
                    .frame(width: 16)
            } //Timer와 끝내기 버튼
            ZStack{ //QuestionView의 메인 내용과 ReactionView를 ZStack으로 쌓아놓기
                VStack{ //QuestionView의 메인 내용(프로필과 질문버튼, 리액션버튼)
                    Group{
                        Spacer()
                            .frame(height: 70)
                        ZStack{
                            Circle()
                                .frame(width:220)
                                .foregroundColor(.blue)
                                .overlay(
                                    Circle()
                                        .stroke(lineWidth: 5)
                                        .foregroundColor(.white)
                                        .shadow(radius: 10)
                                )
                            Text("UserProfile")
                                .foregroundColor(.white)
                                .font(.system(size: 40))
                        }
                        Text("UserName")
                        Spacer()
                        Button(action: {
                            showHintModal = true
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width:159, height: 33)
                                    .foregroundColor(Color("pauseButton"))
                                HStack{
                                    Text("?")
                                        .foregroundColor(.white)
                                        .background(Circle()
                                            .frame(width: 18))
                                    Text("내 질문을 도와줘!")
                                        .font(.system(size:16))
                                        .padding(3)
                                }
                            }
                        })
                        .sheet(isPresented: $showHintModal) {
                            HintModal()
                                .presentationDetents([.height(400)])
                                .presentationCornerRadius(32)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 103)
                                .foregroundColor(.gray.opacity(0.1))
                                .frame(width: 393, height: 206)
                            HStack{
                                Button(action: { //reaaction button action
                                    reactionState = true
                                    withAnimation(.spring(response: 0.4,dampingFraction: 0.25,blendDuration: 0.0)){
                                        isReaction.toggle()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                                        withAnimation(.default){
                                            isReaction.toggle()
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
                                            .foregroundColor(Color("reactionGood"))
                                            .bold()
                                            .padding(.trailing, 15)
                                    }
                                })
                                Button(action: {
                                    reactionState = false
                                    withAnimation(.spring(response: 0.4,dampingFraction: 0.25,blendDuration: 0.0)){
                                        isReaction.toggle()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                                        withAnimation(.default){
                                            isReaction.toggle()
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
                                            .foregroundColor(Color("reactionQuestion"))
                                            .bold()
                                            .padding(.leading, 15)
                                    }
                                })
                            }
                        }
                    }
                }
                //ReactionView
                ReactionView(game: RealTimeGame(),isReaction: self.$isReaction, reactionState: self.$reactionState)
                    .opacity(isReaction ? 1 : 0)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(game: RealTimeGame())
            .environmentObject(TimerModel())
    }
}
