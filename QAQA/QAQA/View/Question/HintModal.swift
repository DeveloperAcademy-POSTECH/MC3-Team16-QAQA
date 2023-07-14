//
//  HintModal.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/12.
//

import SwiftUI

struct HintModal: View {
    
    enum HintMode: String, CaseIterable, Identifiable {
        case fun, serious
        var id: Self { self }
    }
    
    @State private var selectedHint: HintMode = .fun
    @State private var randomFunQuestion : String = "0"
    @State private var randomSeriousQuestion : String = "00"
    
    private let funHints = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private let seriousHints = ["00", "11", "22", "33", "44", "55", "66", "77", "88", "99"]
    
    var body: some View {
        
        VStack{
            Picker("HintMode", selection: $selectedHint) {
                ForEach(HintMode.allCases) { hintMode in
                    Text(hintMode.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedHint, perform: { _ in
                switch selectedHint {
                case .fun :
                    randomFunQuestion = funHints.randomElement()!
                case .serious :
                    randomSeriousQuestion = seriousHints.randomElement()!
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
                    randomFunQuestion = funHints.randomElement()!
                case .serious :
                    randomSeriousQuestion = seriousHints.randomElement()!
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
