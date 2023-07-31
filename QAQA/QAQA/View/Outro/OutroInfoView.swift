//
//  OutroInfoView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/16.
//

import SwiftUI

struct OutroInfoView: View {
    var body: some View {
        ZStack{
            Color.white
            VStack(spacing: 0) {
                ZStack{
                    Image("questionBubble")
                    VStack {
                        Text("질문 끝!")
                            .font(.custom("BMJUAOTF", size: 53))
                        Spacer()
                            .frame(height: 20)
                    }
                }
                Spacer()
                    .frame(height: 5)
                Image("outroInfoViewQaqa")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 202)
            }
        }
    }
}

struct OutroInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OutroInfoView()
    }
}
