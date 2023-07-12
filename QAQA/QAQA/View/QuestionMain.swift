//
//  QuestionMainView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/11.
//

import SwiftUI

struct QuestionMain: View {
    
    @State private var showEasyModal = false
    @State private var showHardModal = false
    
    var body: some View {
        HStack{
            Button("Easy") {
                showEasyModal = true
            }.sheet(isPresented: $showEasyModal) {
                EasyModal()
                    .presentationDetents([.large, .medium, .fraction(0.75)])
            }
            Button("Hard") {
                showHardModal = true
            }.sheet(isPresented: $showHardModal) {
                HardModal()
                    .presentationDetents([.large, .medium, .fraction(0.75)])
            }
        }
    }
}

struct QuestionMain_Previews: PreviewProvider {
    static var previews: some View {
        QuestionMain()
    }
}
