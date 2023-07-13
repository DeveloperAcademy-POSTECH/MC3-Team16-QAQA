//
//  ReactionModifier.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/13.
//

import Foundation
import SwiftUI

struct ReactionModifier: ViewModifier {
    @State var time = 0.0
    let duration = 1.0

    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundColor(.red)
                .modifier(ReactionEffect(time: time))
                .opacity(time == 1.0 ? 0 : 1)
        }
        .onAppear {
            withAnimation(.easeOut(duration: duration)) {
                self.time = duration
            }
        }
    }
}

struct ReactionEffect: GeometryEffect {
    var time: Double
    var speed = Double.random(in: 200 ... 250)
    var xDirection = Double.random(in: -0.2 ... 0.2)
    var yDirection = Double.random(in: -Double.pi ... 0)

    var animatableData: Double {
        get { time }
        set { time = newValue }
    }

    func effectValue(size _: CGSize) -> ProjectionTransform {
        let xTranslation = speed * xDirection
        let yTranslation = speed * sin(yDirection) * time
        let affineTranslation = CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
} 
