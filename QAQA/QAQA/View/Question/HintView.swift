//
//  HintModal.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/12.
//

import SwiftUI

struct HintView: View {
    
    @StateObject private var hintViewModel = HintViewModel()
    @State private var selectedHint: HintState = .fun
    @State private var randomFunQuestion : String = "질문 뽑기 버튼을 눌러보세요!"
    @State private var randomSeriousQuestion : String = "질문 뽑기 버튼을 눌러보세요!"
    
    var body: some View {
        
        VStack{
            Spacer()
                .frame(height: 20)
            Picker("HintMode", selection: $selectedHint) {
                ForEach(HintState.allCases) { hintMode in
                    Text(hintMode.rawValue.capitalized)
                }
            }
            .frame(width: 250)
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
                .frame(height: 62)
            
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
                .frame(height: 65)
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
                    Text("질문 뽑기")
                } .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding([.leading, .trailing], 30)
                    .padding([.top, .bottom], 14)
                    .background(Color(red: 0, green: 0.64, blue: 1))
                    .cornerRadius(16)
            }
            Spacer()
                .frame(height: 24)
        }
    }
}


struct HintModal_Previews: PreviewProvider {
    static var previews: some View {
        HintView()
    }
}
