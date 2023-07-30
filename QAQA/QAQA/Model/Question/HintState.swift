//
//  HintState.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/14.
//

import Foundation

enum HintState: String, CaseIterable, Identifiable {
    case getToKnow, fun, serious
    var id: Self { self }
}
