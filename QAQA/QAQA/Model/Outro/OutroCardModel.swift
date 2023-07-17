//
//  OutroCardModel.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/17.
//

import SwiftUI

struct OutroCardModel: Identifiable {
    let id = UUID()
    
    var cardText: String
    var cardProfile: Image
    var cardUserName: String
    var isShowingCrown: Bool
}
