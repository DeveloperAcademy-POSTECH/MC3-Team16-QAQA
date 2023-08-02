//
//  OutroResultCardView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/28.
//

import SwiftUI

struct OutroResultCardView: View {
    @ObservedObject var game: RealTimeGame
    @State private var totalReaction = 100
    
    var body: some View {
        HStack (spacing: 15) {
            ZStack {
                Image("outroResultRectangle_Orange")
                    .resizable()
                    .frame(width: 109, height: 104)
                VStack {
                    Spacer()
                        .frame(height: 25)
                    Text("\(game.reactionScore)")
                        .font(.custom("BMJUAOTF", size: 25))
                        .foregroundColor(.black)
                    Spacer()
                        .frame(height: 45)
                }
            }
            ZStack {
                Image("outroResultRectangle_Yellow")
                    .resizable()
                    .frame(width: 109, height: 104)
                VStack {
                    Spacer()
                        .frame(height: 25)
                    Text("\(game.kingjungKing)") //킹정킹 username
                        .font(.custom("BMJUAOTF", size: 25))
                        .foregroundColor(.black)
                    Spacer()
                        .frame(height: 45)
                }
            }
            ZStack {
                Image("outroResultRectangle_Green")
                    .resizable()
                    .frame(width: 109, height: 104)
                VStack {
                    Spacer()
                        .frame(height: 25)
                    Text("\(game.evaKing)") //에바킹 username
                        .font(.custom("BMJUAOTF", size: 25))
                        .foregroundColor(.black)
                    Spacer()
                        .frame(height: 45)
                }
            }
        }
        .padding([.leading, .trailing], 16)
    }
}

struct OutroResultCardView_Previews: PreviewProvider {
    static var previews: some View {
        OutroResultCardView(game: RealTimeGame())
    }
}
