//
//  Content_test.swift
//  QAQA
//
//  Created by 조호식 on 2023/07/24.
//

import SwiftUI

struct Content_test: View {
    @StateObject var gyroManager = GyroscopeManager()

    var body: some View {
        BallContainerView(gyroscopeManager: gyroManager)
    }
}
