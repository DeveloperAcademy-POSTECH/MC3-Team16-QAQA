//
//  BeginQuestionModalView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/30.
//

import SwiftUI

struct BeginQuestionModalView: View {
    var body: some View {
        VStack{
            Text("질문 폭격")
            HStack{
                Text("alarm.fill")
                Text("10분")
            }
        }
    }
}

struct BeginQuestionModalView_Previews: PreviewProvider {
    static var previews: some View {
        BeginQuestionModalView()
    }
}
