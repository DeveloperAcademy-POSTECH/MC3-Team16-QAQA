//
//  QuestionView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import SwiftUI

struct QuestionView: View {
    @ObservedObject var game: RealTimeGame
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                game.myAvatar
                    .resizable()
                    .frame(width: 35.0, height: 35.0)
                    .clipShape(Circle())
                
                Text(game.myName + " (me)")
                    .lineLimit(2)
                Spacer()
                game.opponentAvatar
                    .resizable()
                    .frame(width: 35.0, height: 35.0)
                    .clipShape(Circle())
                
                Text(game.opponentName)
                    .lineLimit(2)
                Spacer()
            }
            Button {
                // end Game
                game.endMatch()
                game.resetMatch() // 이 함수에서 game.playingGame을 false로 reset 시켜주면서 창을 닫아줍니다.
            } label: {
                Text("Close")
            }

        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(game: RealTimeGame())
    }
}
