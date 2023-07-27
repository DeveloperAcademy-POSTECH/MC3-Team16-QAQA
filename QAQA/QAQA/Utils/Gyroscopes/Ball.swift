//
//  Ball.swift
//  QAQA
//
//  Created by 조호식 on 2023/07/24.
//

import SwiftUI

struct Ball: View {
    @Binding var gyroImage: String // Ball이 사용할 이미지 이름을 바인딩으로 받습니다.
    var body: some View {
        Image(self.gyroImage)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
    }
}
