//
//  TimerModel.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import Foundation

class TimerModel: ObservableObject {
    @Published var countMin = 10
    @Published var countSecond = 0
    @Published var isTimer = false
}
