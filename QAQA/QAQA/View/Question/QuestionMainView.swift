//
//  QuestionMainView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/12.
//

import SwiftUI

struct QuestionMainView: View {
    
    @State private var showHintModal = false
    
    var body: some View {
        HStack{
            Button("Modal") {
                showHintModal = true
            }.sheet(isPresented: $showHintModal) {
                HintModal()
                    .presentationDetents([.height(311)])
                    .presentationCornerRadius(40)
            }
        }
    }
}


struct QuestionMainView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionMainView()
    }
}
