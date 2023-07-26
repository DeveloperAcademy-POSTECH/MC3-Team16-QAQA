//
//  LoadingView.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/26.
//

import SwiftUI
 
struct LoadingView: View {
    var body: some View {
                ReactionLottieView(jsonName:"goodReactionLottie")
                    .frame(width: 400, height: 400)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
