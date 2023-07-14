//
//  HintModal.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/12.
//

import SwiftUI

struct HintModal: View {
    
    @StateObject private var hintViewModel = HintViewModel()
    @State private var selectedHint: HintState = .fun
    @State private var randomFunQuestion : String = "0"
    @State private var randomSeriousQuestion : String = "00"
    
    var body: some View {
        
        VStack{
            Picker("HintMode", selection: $selectedHint) {
                ForEach(HintState.allCases) { hintMode in
                    Text(hintMode.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedHint, perform: { _ in
                switch selectedHint {
                case .fun :
                    randomFunQuestion = hintViewModel.createRandomFunHints()
                case .serious :
                    randomSeriousQuestion = hintViewModel.createRandomSeriousHints()
                }
            })
            
            .padding()
            Spacer()
                .frame(height: 90)
            
            switch selectedHint {
            case .fun :
                Text("\(randomFunQuestion)")
                    .font(.system(size: 30))
            case .serious :
                Text("\(randomSeriousQuestion)")
                    .font(.system(size: 30))
            }
            Spacer()
                .frame(height: 90)
            Button ("질문 다시 뽑기") {
                switch selectedHint {
                case .fun :
                    randomFunQuestion = hintViewModel.createRandomFunHints()
                case .serious :
                    randomSeriousQuestion = hintViewModel.createRandomSeriousHints()
                }
            }
            .buttonStyle(.borderedProminent)
            .font(.system(size: 25))
        }
    }
}


struct HintModal_Previews: PreviewProvider {
    static var previews: some View {
        HintModal()
    }
}
