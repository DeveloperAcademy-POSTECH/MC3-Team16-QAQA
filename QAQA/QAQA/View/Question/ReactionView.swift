//
//  ReactionView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/17.
//

import SwiftUI

struct ReactionView: View {
    @ObservedObject var game: RealTimeGame
    @Binding var isReaction: Bool
    @Binding var reactionState: Bool
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .ignoresSafeArea()
                .frame(width: UIScreen.width, height: UIScreen.height * 0.82)
                
            VStack{
               
                ZStack{
                    Circle() //reaction용 서클
                        .frame(width:220)
                        .foregroundColor(reactionState ? Color("reactionGood") : Color("reactionQuestion"))
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
                            .frame(width:137, height:129)
                            .offset(x: isReaction ? 0 : 100, y: isReaction ? 0 : 380)
                    }
                    
                        
                }
                Image(reactionState ? "kingjung" : "eva")
                    .resizable()
                    .frame(width: 192, height:90)
                    .padding(55)
                Text("by Euiseo Park")
                    .font(.system(size:20))
                    .foregroundColor(.gray)
                game.myAvatar
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
            }
        }
        
    }
}

struct ReactionView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionView(game: RealTimeGame(), isReaction: QuestionView(game: RealTimeGame()).$isReaction, reactionState: QuestionView(game: RealTimeGame()).$reactionState)
    }
}
