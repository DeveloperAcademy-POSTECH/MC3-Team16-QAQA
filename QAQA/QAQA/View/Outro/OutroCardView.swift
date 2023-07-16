//
//  OutroCardView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/17.
//

import SwiftUI

struct OutroCardView: View {
    private let shadowOpacity = 0.16
    private var text: String
    private var profile: Image
    private var username: String
    private var isShowingCrown: Bool
    
    init(text: String, profile: Image, username: String, isShowingCrown: Bool) {
        self.text = text
        self.profile = profile
        self.username = username
        self.isShowingCrown = isShowingCrown
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .frame(width: 192, height: 246)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(shadowOpacity), radius: 18)
            VStack {
                Text(text)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                Spacer().frame(height: 24)
                ZStack {
                    profile
                        .resizable()
                        .frame(width: 116, height: 116)
                    if (isShowingCrown) {
                        Image("outroCrown")
                            .padding(.leading, 76)
                            .padding(.bottom, 93)
                    }
                }
                Spacer()
                    .frame(height: 10)
                Text(username)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                
            }
        }
    }
}

struct OutroCardView_Previews: PreviewProvider {
    static var previews: some View {
        OutroCardView(text: "가장 와따 많이 한 사람", profile: Image(systemName: "circle.fill"), username: "김복순", isShowingCrown: true)
    }
}
