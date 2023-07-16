//
//  OutroEndingView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/16.
//

import SwiftUI

struct OutroEndingView: View {
    @State private var isShowingInfoView = true
    @State private var userName = "웃쾌마"
    @State private var reactionNum = 24
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 63)
                Text("\(userName) 님이")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                Spacer()
                    .frame(height: 16)
                Text("\(reactionNum)")
                    .font(.system(size: 80))
                    .fontWeight(.bold)
                Spacer()
                    .frame(height: 8)
                Text("개의 반응을 받았어요!")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        OutroCardView(text: "가장 많이 반응한 분", profile: Image(systemName: "circle.fill"), username: "username", isShowingCrown: true) // TODO: 모델로 변환, 모델 리스트 만들어서 받아온 후 값 집어넣기
                        Spacer()
                            .frame(width: 20)
                    OutroCardView(text: "킹정~ 많이한 분", profile: Image(systemName: "circle.fill"), username: "username", isShowingCrown: false)
                        Spacer()
                            .frame(width: 20)
                    OutroCardView(text: "에바~ 많이한 분", profile: Image(systemName: "circle.fill"), username: "username", isShowingCrown: false)
                    }
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 70)
                    // TODO: 자동 스크롤 효과
                }
                Spacer()
                    .frame(height: 10)
                Button {
                    // action
                } label: {
                    Text("수고하셨습니다!")
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 20)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 16))
                }.padding(.bottom, 16)
                    .padding([.leading, .trailing], 16)
                
            }
            if (isShowingInfoView) { // TODO: animation
                OutroInfoView()
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isShowingInfoView.toggle()
                        }
                    }
            }
        }
    }
}

struct OutroEndingView_Previews: PreviewProvider {
    static var previews: some View {
        OutroEndingView()
    }
}
