//
//  ReactionView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/17.
//

import SwiftUI

struct ReactionView: View {
    @ObservedObject var game: RealTimeGame
    @Binding var isReaction: Bool //리액션뷰 온오프하는 변수
    @Binding var isKingjungReaction: Bool //킹정인지 에바인지 고르는 변수 true면 킹정 false면 에바
    var body: some View {
        ZStack{
            Color.white
            VStack{
                if (isKingjungReaction) {
                    ReactionLottieView(jsonName:"goodReactionLottie")
                        .frame(width: 390, height: 390)
                } else {
                    ReactionLottieView(jsonName:"badReactionLottie")
                        .frame(width: 390, height: 390)
                }
            }
            .frame(height: 541)
        }
    }
}

//struct ReactionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReactionView(game: RealTimeGame(), isReaction: QuestionView(game: RealTimeGame()).$isReaction, reactionState: QuestionView(game: RealTimeGame()).$reactionState)
//    }
//}
