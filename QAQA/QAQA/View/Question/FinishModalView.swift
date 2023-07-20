//
//  FinishModalView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/19.
//

import SwiftUI

struct FinishModalView: View {
    @Binding var isShowingOutroView: Bool
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack{
            Text("활동을 끝내시겠어요?")
                .bold()
                .font(.system(size: 28))
                .padding(19)
            Text("팀원들 모두 종료됩니다")
                .foregroundColor(.gray)
                .bold()
                .font(.system(size: 16))
                .padding(.bottom, 42)
            Button{
                presentation.wrappedValue.dismiss()
                isShowingOutroView.toggle()
            } label: {
                Text("종료하기")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding([.leading,.trailing],152)
                    .padding([.top,.bottom],20)
                    .background(RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.red)
                    )
            }
          
        
        }
        
    }
}

struct FinishModalView_Previews: PreviewProvider {
    static var previews: some View {
        FinishModalView(isShowingOutroView: QuestionView(mainViewNavLinkActive: .constant(false), game: RealTimeGame()).$isShowingOutroView)
    }
}
