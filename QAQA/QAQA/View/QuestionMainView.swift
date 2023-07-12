//
//  QuestionMainView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/12.
//

import SwiftUI

struct QuestionMainView: View {
    
    @State private var showEasyModal = false
    @State private var showHardModal = false
    
    var body: some View {
        HStack{
            Button("Easy") {
                showEasyModal = true
            }.sheet(isPresented: $showEasyModal) {
                EasyModal()
//                    .presentationDetents([.fraction(0.5)])
                    .presentationDetents([.height(311)])
                    .presentationCornerRadius(40)
            }
            .cornerRadius(100)
            Button("Hard") {
                showHardModal = true
            }.sheet(isPresented: $showHardModal) {
                HardModal()
                    .presentationDetents([.large, .medium, .fraction(0.75)])
            }
        }
    }
}


struct QuestionMainView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionMainView()
    }
}
