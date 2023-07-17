//
//  OutroViewModel.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/16.
//

import SwiftUI

class OutroViewModel: ObservableObject {
    var cardModels: [OutroCardModel] = [
        OutroCardModel(cardText: "가장 많이 반응한 분", cardProfile: Image(systemName: "circle.fill"), cardUserName: "username", isShowingCrown: true),
        OutroCardModel(cardText: "킹정~ 많이한 분", cardProfile: Image(systemName: "circle.fill"), cardUserName: "username", isShowingCrown: false),
        OutroCardModel(cardText: "에바~ 많이한 분", cardProfile: Image(systemName: "circle.fill"), cardUserName: "username", isShowingCrown: true),
    ]

    
}
