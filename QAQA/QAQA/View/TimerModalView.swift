//
//  TimerModalView.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import SwiftUI

struct TimerModalView: View {
    @EnvironmentObject var timerModel: TimerModel
    var body: some View {
        Text("\(timerModel.countMin):\(timerModel.countSecond)")
    }
}

struct TimerModalView_Previews: PreviewProvider {
    static var previews: some View {
        TimerModalView()
            .environmentObject(TimerModel())
    }
}
