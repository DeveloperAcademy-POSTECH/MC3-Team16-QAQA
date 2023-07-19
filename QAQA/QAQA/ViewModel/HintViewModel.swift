//
//  ViewModel.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/11.
//

import Foundation

class HintViewModel: ObservableObject {
    private var hintModel = HintModel()
    
    func createRandomFunHints() -> String {
        return hintModel.funHints.randomElement()!
    }
    func createRandomSeriousHints() -> String {
        return hintModel.seriousHints.randomElement()!
    }
    
}
