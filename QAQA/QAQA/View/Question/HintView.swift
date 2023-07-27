//
//  HintModal.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/12.
//

import SwiftUI

struct HintView: View {
    
    @StateObject private var hintViewModel = HintViewModel()
    @State private var selectedHint: HintState = .gettoknow
    @State private var randomGettoknowQuestion : String = "질문 뽑기 버튼을 눌러보세요!"
    @State private var randomFunQuestion : String = "질문 뽑기 버튼을 눌러보세요!"
    @State private var randomSeriousQuestion : String = "질문 뽑기 버튼을 눌러보세요!"
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.hintViewYellow)
                .frame(width: 358, height: 332)
            VStack{
                Spacer()
                    .frame(height: 25)
                Text("궁금한 질문을 골라보세요!")
                    .font(.custom("BMJUAOTF", size: 15))
                    .foregroundColor(.hintViewOrange)
                Spacer()
                    .frame(height: 16)
                Picker("HintMode", selection: $selectedHint) {
                    Text("알아가기").tag(HintState.gettoknow)
                    Text("재미").tag(HintState.fun)
                    Text("진지").tag(HintState.serious)
                }
                .frame(width: 250)
                .pickerStyle(.segmented)
                .onChange(of: selectedHint, perform: { _ in
                    switch selectedHint {
                    case .gettoknow :
                        randomGettoknowQuestion = hintViewModel.createRandomGettoknowHints()
                    case .fun :
                        randomFunQuestion = hintViewModel.createRandomFunHints()
                    case .serious :
                        randomSeriousQuestion = hintViewModel.createRandomSeriousHints()
                    }
                })
                Spacer()
                    .frame(height: 30)
                switch selectedHint {
                case .gettoknow :
                    Text("\(randomGettoknowQuestion)")
                        .font(.custom("BMJUAOTF", size: 25))
                        .frame(width: 320, height: 120)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .lineSpacing(7)
                case .fun :
                    Text("\(randomFunQuestion)")
                        .font(.custom("BMJUAOTF", size: 25))
                        .frame(width: 320, height: 120)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .lineSpacing(7)
                case .serious :
                    Text("\(randomSeriousQuestion)")
                        .font(.custom("BMJUAOTF", size: 25))
                        .frame(width: 320, height: 120)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .lineSpacing(7)
                }
                Spacer()
                    .frame(height: 25)
                Button {
                    switch selectedHint {
                    case .gettoknow :
                        randomGettoknowQuestion =
                        hintViewModel.createRandomGettoknowHints()
                    case .fun :
                        randomFunQuestion = hintViewModel.createRandomFunHints()
                    case .serious :
                        randomSeriousQuestion = hintViewModel.createRandomSeriousHints()
                    }
                } label: {
                    Image("randomHintButton")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 223)
                }
                Spacer()
                    .frame(height: 25)
            }
            .frame(width: 358, height: 332)
        }
    }
}


struct HintModal_Previews: PreviewProvider {
    static var previews: some View {
        HintView()
    }
}
