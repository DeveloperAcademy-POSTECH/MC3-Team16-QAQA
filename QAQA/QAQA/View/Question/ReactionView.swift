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
    @Binding var reactionState: Bool //킹정인지 에바인지 고르는 변수 true면 킹정 false면 에바
    var body: some View {
        ZStack{
            Color.white
            VStack{
                ZStack{
                    Circle() //reaction용 서클
                        .frame(width:220)
                        .foregroundColor(reactionState ? Color("reactionGoodColor") : Color("reactionQuestionColor"))
                        .overlay(
                            Circle()
                                .stroke(lineWidth: 5)
                                .foregroundColor(.white)
                        )
                    if reactionState == true {
                        Image("star")
                            .resizable()
                            .frame(width:137, height:129)
                            .offset(x: isReaction ? 0 : -100, y: isReaction ? 0 : 380)
                    }
                    else{
                        Image("questionMark")
                            .resizable()
                            .frame(width:137, height:137)
                            .offset(x: isReaction ? 0 : 100, y: isReaction ? 0 : 380)
                    }
                    
                        
                }
                Image(reactionState ? "kingjung" : "eva")
                    .resizable()
                    .frame(width: 192, height:90)
                    .padding(60)
                Text("by Your Teammates") //리액션을 누를 사람의 이름 뜨는 곳
                    .font(.system(size:20))
                    .foregroundColor(.gray)
                    .opacity(0)
                game.myAvatar
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .opacity(0)
                
            }
        }
        
    }
}

struct ReactionView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionView(game: RealTimeGame(), isReaction: QuestionView(game: RealTimeGame()).$isReaction, reactionState: QuestionView(game: RealTimeGame()).$reactionState)
    }
}
