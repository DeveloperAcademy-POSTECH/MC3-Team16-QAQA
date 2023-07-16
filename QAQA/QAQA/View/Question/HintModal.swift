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
                .frame(height: 65)
            
            switch selectedHint {
            case .fun :
                Text("\(randomFunQuestion)")
                    .font(.system(size: 32, weight: .bold))
                    .frame(width: 327, height: 114)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            case .serious :
                Text("\(randomSeriousQuestion)")
                    .font(.system(size: 32, weight: .bold))
                    .frame(width: 327, height: 114)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }
            Spacer()
                .frame(height: 55)
            Button(action: {
                switch selectedHint {
                case .fun :
                    randomFunQuestion = hintViewModel.createRandomFunHints()
                case .serious :
                    randomSeriousQuestion = hintViewModel.createRandomSeriousHints()
                }
            }) {
                HStack {
                    Image(systemName: "dice.fill")
                    Text("질문 다시 뽑기")
                } .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 199, height: 52)
                    .background(Color(red: 0, green: 0.64, blue: 1))
                    .cornerRadius(16)
            }
        }
    }
}


struct HintModal_Previews: PreviewProvider {
    static var previews: some View {
        HintModal()
    }
}
