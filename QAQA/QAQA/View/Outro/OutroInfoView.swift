//
//  OutroInfoView.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/16.
//

import SwiftUI

struct OutroInfoView: View {
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Spacer()
                    .frame(height: 229)
                Image("outroCharacter")
                Spacer()
                    .frame(height: 75)
                Text("질문폭격 끝!")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                Spacer()
            }
        }
    }
}

struct OutroInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OutroInfoView()
    }
}
