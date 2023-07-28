////
////  HapticTestView.swift
////  QAQA
////
////  Created by 조호식 on 2023/07/16.
////
//
//import SwiftUI
//
//struct HapticTestView: View {
//    @ObservedObject var hapticManager = HapticFeedbackManager()
//    
//    var body: some View {
//        Text("simpleSuccess")
//            .padding()
//            .onTapGesture(perform: hapticManager.simpleSuccess)
//        
//        Text("simpleError")
//            .padding()
//            .onTapGesture(perform: hapticManager.simpleError)
//        
//        Text("simpleWarning")
//            .padding()
//            .onTapGesture(perform: hapticManager.simpleWarning)
//        
//        Text("complexMountain")
//            .padding()
//            .onAppear(perform: hapticManager.prepareHaptics)
//            .onTapGesture(perform: hapticManager.complexMountain)
//        
//        Text("complexValley")
//            .padding()
//            .onAppear(perform: hapticManager.prepareHaptics)
//            .onTapGesture(perform: hapticManager.complexValley)
//        
//        Text("sosHaptics")
//            .padding()
//            .onAppear(perform: hapticManager.prepareHaptics)
//            .onTapGesture(perform: hapticManager.sosHaptics)
//        
//        Text("veryGoodHaptics")
//            .padding()
//            .onAppear(perform: hapticManager.prepareHaptics)
//            .onTapGesture(perform: hapticManager.veryGoodHaptics)
//        
//        
//    }
//}
//
//struct HapticTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        HapticTestView()
//    }
//}
