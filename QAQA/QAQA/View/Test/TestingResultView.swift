//
//  TestingResultView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/31.
//

import SwiftUI

struct TestingResultView: View {
    @ObservedObject var game: RealTimeGame
    var body: some View {
        ZStack{
            Color.white
            Text("Hello, \(game.topicUserName)")
        }
        
    }
}

struct TestingResultView_Previews: PreviewProvider {
    static var previews: some View {
        TestingResultView(game: RealTimeGame())
    }
}
