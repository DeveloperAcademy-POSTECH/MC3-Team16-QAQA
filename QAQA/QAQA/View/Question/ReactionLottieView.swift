//
//ReactionLottieView.swift
//QAQA
//
//Created by 김혜린 on 2023/07/26.

import Lottie
import SwiftUI
import UIKit

struct ReactionLottieView: UIViewRepresentable {
    var name : String
    var loopMode: LottieLoopMode
    
    
    init(jsonName: String = "", loopMode : LottieLoopMode = .loop){
        self.name = jsonName
        self.loopMode = loopMode
    }
    
    func makeUIView(context: UIViewRepresentableContext<ReactionLottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ReactionLottieView>) {
        // do nothing
    }
    
}

struct ReactionLottieView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionLottieView()
    }
}
