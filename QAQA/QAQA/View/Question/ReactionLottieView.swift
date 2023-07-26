//
//  ReactionView2.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/26.
//

//import SwiftUI
//import Lottie
//import UIKit
//
//struct ReactionLottieView: UIViewRepresentable {
//    var name : String
//        var loopMode: LottieLoopMode
//        
//        init(jsonName: String = "", loopMode : LottieLoopMode = .loop){
//            self.name = jsonName
//            self.loopMode = loopMode
//        }
//
//    
//    func makeUIView(context: UIViewRepresentableContext<ReactionLottieView>) -> UIView {
//            let view = UIView(frame: .zero)
//
//            let animationView = goodReactionLottie()
//            let animation = Animation.named(name)
//            animationView.animation = animation
//            animationView.contentMode = .scaleAspectFit
//            animationView.loopMode = loopMode
//            animationView.play()
//            animationView.backgroundBehavior = .pauseAndRestore
//      
//          animationView.translatesAutoresizingMaskIntoConstraints = false
//            
//            view.addSubview(animationView)
//            NSLayoutConstraint.activate([
//                animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
//                animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
//            ])
//
//            return view
//        }
//
//        func updateUIView(_ uiView: UIViewType, context: Context) {
//        }
//    }
//
//struct ReactionLottieView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReactionLottieView()
//    }
//}
