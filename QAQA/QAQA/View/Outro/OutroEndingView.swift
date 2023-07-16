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
                Text("\(userName) 님,")
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
                        Rectangle()
                            .frame(width: 192, height: 246)
                        Spacer()
                            .frame(width: 20)
                        Rectangle()
                            .frame(width: 192, height: 246)
                    }
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 70)
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
