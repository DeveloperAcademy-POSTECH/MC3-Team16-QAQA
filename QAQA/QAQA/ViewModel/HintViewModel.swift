//
//  ViewModel.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import Foundation

class HintViewModel: ObservableObject {
    private var hintModel = HintModel()
    
    func createRandomGetToKnowHints() -> String {
        return hintModel.getToKnowHints.randomElement()!
    }
    func createRandomFunHints() -> String {
        return hintModel.funHints.randomElement()!
    }
    func createRandomSeriousHints() -> String {
        return hintModel.seriousHints.randomElement()!
    }
    
}
