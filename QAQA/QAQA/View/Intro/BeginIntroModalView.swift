//
//  BeginIntroModalView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/31.
//

import SwiftUI

struct BeginIntroModalView: View {
    
    var body: some View {
        VStack(spacing: 0){
            Spacer()
                .frame(height: 22)
            Text("미니 게임")
                .font(.custom("BMJUAOTF", size: 14))
                .foregroundColor(.gray)
            Spacer()
                .frame(height: 5)
            HStack{
                Image(systemName: "alarm.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .foregroundColor(.outroGaugeGreen)
                Text("10분")
                    .font(.custom("BMJUAOTF", size: 30))
                    .foregroundColor(.outroGaugeGreen)
            }
            Spacer()
                .frame(height: 9)
            Image("beginIntroModalQaqa")
                .resizable()
                .scaledToFit()
                .frame(width: 162)
            Spacer()
                .frame(height: 17)
            Group {
                Text("질문하기 전 잠깐!\n몸풀기 게임을 즐겨볼까요?\n폭탄을 돌려서 오늘의 주인공을 뽑아요!")
                    .font(.custom("BMJUAOTF", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 350)
                    .lineSpacing(5)
                Spacer()
                    .frame(height: 24)
            }
            Button {
           // 시작하기 버튼 액션 (연결 필요)
            } label: {
                Image("startButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 358)
            }
        }
    }
}

struct BeginIntroModalView_Previews: PreviewProvider {
    static var previews: some View {
        BeginIntroModalView()
    }
}
