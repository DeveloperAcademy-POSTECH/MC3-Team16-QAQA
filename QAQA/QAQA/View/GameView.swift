//
//  GameView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: RealTimeGame
    
    var body: some View {
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
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: RealTimeGame())
    }
}
