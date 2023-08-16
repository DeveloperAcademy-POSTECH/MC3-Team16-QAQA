//
//  TimerNoCountView.swift
//  QAQA
//
//  Created by 김기영 on 2023/08/16.
//

import SwiftUI

struct TimerNoCountView: View {
    @ObservedObject var game: RealTimeGame
    @Binding var isShowingOutroView: Bool
    @State var fontSize = 30.0
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Text((game.countSecond < 10) ? "\(game.countMin):0\(game.countSecond)" : "\(game.countMin):\(game.countSecond)")
                    .font(.custom("BMJUAOTF", size: fontSize))
                    .foregroundColor(.black)
                    .onChange(of: game.countSecond, perform: { _ in
                        if (game.countMin == 0) && (game.countSecond == 0) {
                            isShowingOutroView.toggle()
                            game.endMatch()
                            game.reportProgress() // -> gameIsEnd가 true 됨
                        }
                    })
            }
        }
    }
}

//struct TimerNoCountView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerNoCountView()
//    }
//}
