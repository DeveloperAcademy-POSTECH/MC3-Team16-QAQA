//
//  OutroEndingViewModel.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/28.
//

import Foundation

class OutroEndingViewModel: ObservableObject {
    func calculateKingjungWidth(kingjung: CGFloat, total: CGFloat) -> CGFloat {
        return (kingjung / total) * 360
    }
    func calculateEvaWidth(eva: CGFloat, total: CGFloat) -> CGFloat {
        return (eva / total) * 360
    }
    func calculateSpacerWidth(kingjung: CGFloat, eva: CGFloat, total: CGFloat) -> CGFloat {
        return 360 - ((kingjung / total) * 360 + (eva / total) * 360)
    }
}
