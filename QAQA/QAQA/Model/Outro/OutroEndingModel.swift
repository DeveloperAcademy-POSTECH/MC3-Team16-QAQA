//
//  OutroEndingModel.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/28.
//

import Foundation

class OutroEndingModel: ObservableObject {
    
    @Published var totalKingjung: CGFloat = 10 // 총 킹정 리액션 수
    @Published var totalEva: CGFloat = 10 // 총 에바 리액션 수
    @Published var totalReaction: CGFloat = 20 // 총 리액션 수
}
