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
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    Spacer()
                    Button {
                        // end Game
                        game.endMatch()
                        game.resetMatch() // 이 함수에서 game.playingGame을 false로 reset 시켜주면서 창을 닫아줍니다.
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 33, height: 33)
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                    }
                }
                Spacer()
                    .frame(height: 81)
                game.myAvatar
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                Spacer()
                    .frame(height: 20)
                Text("오늘의 주인공\n\(game.myName)")
                    .font(.system(size: 32))
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 74)
                
                HStack {
                    // Timer
                    TimerView(width:130)
                    //                    Rectangle()
                    //                        .frame(width: 150, height: 50)
                    Spacer().frame(width: 10)
                    // Pause and Play Button
                    Button {
                        timerModel.isTimer.toggle()
                        showTimerModal = true// action
                    } label: {
                        Image(systemName: "pause.fill" )
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Circle())
                    }
                    .sheet(isPresented: $showTimerModal){
                        TimerModalView()
                            .presentationDetents([.height(257)])
                            .presentationCornerRadius(32)
                            .padding(.top, 30)
                        
                        
                        
                    }
                    
                }
                Spacer()
                    .frame(height: 15)
                Button {
                    // Hint Button Action
                } label: {
                    Text("Hint Button")
                }
            }
            
            Spacer()
                .frame(height: 36)
            
            HStack {
                Button {
                    goodReactionCount += 1// Left Button Action
                } label: {
                    ZStack{
                        Text("🥰")
                            .font(.system(size: 121))
                            .padding(20)
                            .background(Circle()
                                .foregroundColor(.yellow))
                        ForEach(0 ..< goodReactionCount, id: \.self){ _ in
                            Text("🥰")
                                .font(.system(size: Double.random(in: 50...70)))
                                .modifier(ReactionModifier())
                                .offset(y:-80)
                        }
                    }
                    Spacer()
                        .frame(width: 21)
                    Button {
                        ummReactionCount += 1// Right Button Action
                    } label: {
                        ZStack{
                            Text("🧐")
                                .font(.system(size: 121))
                                .padding(20)
                                .background(Circle()
                                    .foregroundColor(.green))
                            ForEach(0 ..< ummReactionCount, id: \.self){ _ in
                                Text("🧐")
                                    .font(.system(size: Double.random(in: 50...70)))
                                    .modifier(ReactionModifier())
                                    .offset(y:-80)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear{
            timerModel.isTimer.toggle()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(game: RealTimeGame())
            .environmentObject(TimerModel())
    }
}
