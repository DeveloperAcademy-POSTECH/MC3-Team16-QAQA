//
//  HintModal.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/12.
//

import SwiftUI

struct HintModal: View {
    
    enum HintMode: String, CaseIterable, Identifiable {
        case easy, hard
        var id: Self { self }
    }
    
    @State private var selectedHint: HintMode = .easy
    
    let easyhints = ["1", "2", "3", "4", "5", "6", "7", "8"]
    let hardhints = ["11", "22", "33", "44", "55", "66", "77", "88"]
    
    var body: some View {
        VStack{
            Text("Hint Modal")
            Picker("HintMode", selection: $selectedHint) {
                ForEach(HintMode.allCases) { hintMode in
                    Text(hintMode.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Text("\(selectedHint.rawValue)")
            
            if selectedHint == .easy {
                if let easyhint = easyhints.randomElement() {
                    Text("\(easyhint)")
                }
            }else {
                if let hardhint = hardhints.randomElement() {
                    Text("\(hardhint)")
                }
            }
        }
    }
}


struct HintModal_Previews: PreviewProvider {
    static var previews: some View {
        HintModal()
    }
}
