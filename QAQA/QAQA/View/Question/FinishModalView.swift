//
//  FinishModalView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/19.
//

import SwiftUI

struct FinishModalView: View {
    @Binding var isShowingOutroView: Bool
    @ObservedObject var game: RealTimeGame
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack (spacing: 0) {
            Text("활동을 끝내시겠어요?")
                .bold()
                .font(.custom("BMJUAOTF", size: 28))
                .padding([.top], 46)
                .padding([.bottom], 19)
            Text("팀원들 모두 종료됩니다")
                .foregroundColor(.gray)
                .bold()
                .font(.custom("BMJUAOTF", size: 16))
            Spacer()
                .frame(height: 37)
            Button{
                presentation.wrappedValue.dismiss()
                isShowingOutroView.toggle()
                game.endMatch()
                game.reportProgress() // -> gameIsEnd가 true 됨
            } label: {
                Image("finishButton_Red")
                    .resizable()
                    .frame(height: 53)
            }
            .padding([.leading, .trailing], 16)
        }
        .presentationCornerRadius(32)
    }
}

struct FinishModalView_Previews: PreviewProvider {
    static var previews: some View {
        FinishModalView(isShowingOutroView: .constant(false), game: RealTimeGame())
    }
}
