//
//  QuestionMainView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/11.
//

import SwiftUI

struct QuestionMain: View {
    
    @State private var showModal = false
    
    var body: some View {
        HStack{
            Button("Easy") {
                showModal = true
            }
            Button("Hard") {
                
            }
        }
    }
}

struct QuestionMain_Previews: PreviewProvider {
    static var previews: some View {
        QuestionMain()
    }
}
