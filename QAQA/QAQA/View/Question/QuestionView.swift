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
    @State var goodReactionCount = 0
    @State var ummReactionCount = 0
    @State var showTimerModal = false
    @State var isReaction = false 
    @State var reactionState = false
    
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
                    //끝내기 버튼
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
            }
            ZStack{
               
                VStack{
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
                        Button(action: {}, label: {
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
                ReactionView(game: RealTimeGame(),isReaction: self.$isReaction, reactionState: self.$reactionState)
                    .opacity(isReaction ? 1 : 0)
                
                
            }
            
           
        }
            //        VStack {
            //            Group {
            //                HStack {
            //                    Spacer()
            //                    Button {
            //                        // end Game
            //                        game.endMatch()
            //                        game.resetMatch() // 이 함수에서 game.playingGame을 false로 reset 시켜주면서 창을 닫아줍니다.
            //                    } label: {
            //                        Image(systemName: "xmark")
            //                            .resizable()
            //                            .frame(width: 33, height: 33)
            //                            .foregroundColor(.black)
            //                            .padding(.trailing, 20)
            //                    }
            //                }
            //                Spacer()
            //                    .frame(height: 81)
//                            game.myAvatar
//                                .resizable()
//                                .frame(width: 200, height: 200)
//                                .clipShape(Circle())
            //                Spacer()
            //                    .frame(height: 20)
            //                Text("오늘의 주인공\n\(game.myName)")
            //                    .font(.system(size: 32))
            //                    .multilineTextAlignment(.center)
            //                Spacer()
            //                    .frame(height: 74)
            //
            //                HStack {
            //                    // Timer
            //                    TimerView(width:130)
            //                    //                    Rectangle()
            //                    //                        .frame(width: 150, height: 50)
            //                    Spacer().frame(width: 10)
            //                    // Pause and Play Button
            //                    Button {
            //                        timerModel.isTimer.toggle()
            //                        showTimerModal = true// action
            //                    } label: {
            //                        Image(systemName: "pause.fill" )
            //                            .foregroundColor(.white)
            //                            .padding(15)
            //                            .background(Circle())
            //                    }
            //                    .sheet(isPresented: $showTimerModal){
            //                        TimerModalView()
            //                            .presentationDetents([.height(257)])
            //                            .presentationCornerRadius(32)
            //                            .padding(.top, 30)
            //
            //
            //
            //                    }
            //
            //                }
            //                Spacer()
            //                    .frame(height: 15)
            //                Button {
            //                    // Hint Button Action
            //                } label: {
            //                    Text("Hint Button")
            //                }
            //            }
            //
            //            Spacer()
            //                .frame(height: 36)
            //
            //            HStack {
            //                Button {
            //                    goodReactionCount += 1// Left Button Action
            //                } label: {
            //                    ZStack{
            //                        Text("🥰")
            //                            .font(.system(size: 121))
            //                            .padding(20)
            //                            .background(Circle()
            //                                .foregroundColor(.yellow))
            //                        ForEach(0 ..< goodReactionCount, id: \.self){ _ in
            //                            Text("🥰")
            //                                .font(.system(size: Double.random(in: 50...70)))
            //                                .modifier(ReactionModifier())
            //                                .offset(y:-80)
            //                        }
            //                    }
            //                    Spacer()
            //                        .frame(width: 21)
            //                    Button {
            //                        ummReactionCount += 1// Right Button Action
            //                    } label: {
            //                        ZStack{
            //                            Text("🧐")
            //                                .font(.system(size: 121))
            //                                .padding(20)
            //                                .background(Circle()
            //                                    .foregroundColor(.green))
            //                            ForEach(0 ..< ummReactionCount, id: \.self){ _ in
            //                                Text("🧐")
            //                                    .font(.system(size: Double.random(in: 50...70)))
            //                                    .modifier(ReactionModifier())
            //                                    .offset(y:-80)
            //                            }
            //                        }
            //                    }
            //                }
            //            }
            //            Spacer()
            //        }
            //        .onAppear{
            //            timerModel.isTimer.toggle()
            //        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(game: RealTimeGame())
            .environmentObject(TimerModel())
    }
}
