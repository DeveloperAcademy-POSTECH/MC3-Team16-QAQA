//
//  QuestionView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import SwiftUI

struct QuestionView: View {
    @ObservedObject var game: RealTimeGame
    @State private var showHintModal = false
    
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
                    Rectangle()
                        .frame(width: 150, height: 50)
                    Spacer().frame(width: 10)
                    // Pause and Play Button
                    Button {
                        // action
                    } label: {
                        Image(systemName: "pause.fill")
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Circle())
                    }
                }
                Spacer()
                    .frame(height: 15)
                Button {
                    // Hint Button Action
                    showHintModal = true
                } label: {
                    Text("Hint Button")
                } .sheet(isPresented: $showHintModal) {
                    HintModal()
                        .presentationDetents([.height(311)])
                        .presentationCornerRadius(40)
                }
            }
            
            Spacer()
                .frame(height: 36)
            HStack {
                Button {
                    // Left Button Action
                } label: {
                    Text("🥰")
                        .font(.system(size: 121))
                        .padding(20)
                        .background(Circle()
                            .foregroundColor(.yellow))
                }
                Spacer()
                    .frame(width: 21)
                Button {
                    // Right Button Action
                } label: {
                    Text("🧐")
                        .font(.system(size: 121))
                        .padding(20)
                        .background(Circle()
                            .foregroundColor(.green))
                }
            }
            Spacer()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(game: RealTimeGame())
    }
}
