//
//  OutroEndingViewModel.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/28.
//

import Foundation

class OutroEndingViewModel: ObservableObject {
    private var outroEndingModel = OutroEndingModel()
    
    func calculateKingjungWidth() -> CGFloat {
        return (outroEndingModel.totalKingjung/outroEndingModel.totalReaction)*360
    }
    func calculateEvaWidth() -> CGFloat {
        return (outroEndingModel.totalEva/outroEndingModel.totalReaction)*360
    }
    func calculateSpacerWidth() -> CGFloat {
        return 360-(calculateKingjungWidth()+calculateEvaWidth())
    }
}
