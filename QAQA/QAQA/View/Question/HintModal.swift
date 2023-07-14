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
    
    let funhints = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let serioushints = ["00", "11", "22", "33", "44", "55", "66", "77", "88", "99"]
    
    var body: some View {
        VStack{
            Picker("HintMode", selection: $selectedHint) {
                ForEach(HintMode.allCases) { hintMode in
                    Text(hintMode.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            Spacer()
                .frame(height: 90)
            Text("\(selectedHint.rawValue)")
                .font(.system(size: 30))
            if selectedHint == .fun {
                if let funhint = funhints.randomElement() {
                    Text("\(funhint)")
                        .font(.system(size: 30))
                }
            }else {
                if let serioushint = serioushints.randomElement() {
                    Text("\(serioushint)")
                        .font(.system(size: 30))
                }
            }
            Spacer()
                .frame(height: 90)
            Button ("질문 다시 뽑기") {
                // Qustion Random Button Action
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
