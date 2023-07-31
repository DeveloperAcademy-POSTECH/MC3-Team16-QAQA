//
//  QAQAApp.swift
//  QAQA
//
//  Created by 박의서 on 2023/07/10.
//

import SwiftUI

@main
struct QAQAApp: App {
    
   @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding == true {
                tutorialView(isOnboarding: $isOnboarding)

            } else {
                HomeView()
            }
        }
    }
}
