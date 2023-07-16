//
//  QAQAApp.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/10.
//

import SwiftUI

@main
struct QAQAApp: App {
    var body: some Scene {
        WindowGroup {
//            HomeView()
            OutroEndingView()
                .environmentObject(TimerModel())
        }
    }
}
