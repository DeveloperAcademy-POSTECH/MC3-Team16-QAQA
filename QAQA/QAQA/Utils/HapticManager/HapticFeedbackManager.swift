////
////  HapticFeedbackManager.swift
////  QAQA
////
////  Created by 조호식 on 2023/07/16.
////
//
//import SwiftUI
//import CoreHaptics
//import UIKit
//
//class HapticFeedbackManager: ObservableObject {
//    var engine: CHHapticEngine?
//    
//
//    func simpleSuccess() {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.success)
//    }
//    
//    func simpleError() {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.error)
//    }
//    
//    func simpleWarning() {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.warning)
//    }
//    
//    
//    
//    //커스텀을 위한엔진 .onAppear(perform: hapticManager.prepareHaptics) 를 같이 넣어줘야함
//    func prepareHaptics() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        
//        do {
//            engine = try CHHapticEngine()
//            try engine?.start()
//        } catch {
//            print("there was an error creating the engine: \(error.localizedDescription)")
//        }
//    }
//    //커스텀을 위한엔진 끝
//    
//    
//    
//    //올라갔다~ 내려갔다~
//    func complexMountain() {
//        // make sure that the device supports haptics
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        
//        var events = [CHHapticEvent]()
//        
//        // create one intense, sharp tap
//        for i in stride(from: 0, to: 1, by: 0.1) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
//            events.append(event)
//        }
//        
//        for i in stride(from: 0, to: 1, by: 0.1) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
//            events.append(event)
//        }
//        // convert those events into a pattern and play it immediately
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("Failed to play pattern: \(error.localizedDescription).")
//        }
//    }
//    //올라갔다~ 내려갔다~ 끝
//    
//    
//    
//    //내려갔다~ 올라갔다~
//    func complexValley() {
//        // make sure that the device supports haptics
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        
//        var events = [CHHapticEvent]()
//        
//        // create one intense, sharp tap
//        for i in stride(from: 0, to: 1, by: 0.1) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
//            events.append(event)
//        }
//
//        for i in stride(from: 0, to: 1, by: 0.1) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
//            events.append(event)
//        }
//        // convert those events into a pattern and play it immediately
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("Failed to play pattern: \(error.localizedDescription).")
//        }
//    }
//    //내려갔다~ 올라갔다~ 끝
//    
//    
//    
//    //S.O.S 따따따 따따 따~ 따따따
//    func sosHaptics() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        
//        let dot: Float = 0.1
//        let dash: Float = 0.3
//        let gap: Float = 0.1
//        
//        let sosPattern: [Float] = [dot, gap, dot, gap, dot, gap, dash, gap, dash, gap, dash, gap, dot, gap, dot, gap, dot]
//        
//        var events = [CHHapticEvent]()
//        var time: Float = 0
//        
//        for duration in sosPattern {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//            
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: TimeInterval(time))
//            events.append(event)
//            
//            time += duration
//        }
//        
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("Failed to play pattern: \(error.localizedDescription).")
//        }
//    }
//    //S.O.S 따따따 따따 따~ 따따따 끝
//    
//    
//    
//    //verygood 모스부호
//    func veryGoodHaptics() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        
//        let dot: Float = 0.1
//        let dash: Float = 0.3
//        let gap: Float = 0.1
//        let letterGap: Float = 0.3
//        
//        // V . . . -
//        // E .
//        // R . - .
//        // Y - . - -
//        // G - - .
//        // O - - -
//        // O - - -
//        // D - . .
//        let veryGoodPattern: [Float] = [dot, gap, dot, gap, dot, gap, dash, letterGap,
//                                        dot, letterGap,
//                                        dot, gap, dash, gap, dot, letterGap,
//                                        dash, gap, dot, gap, dash, gap, dash, letterGap,
//                                        dash, gap, dash, gap, dot, letterGap,
//                                        dash, gap, dash, gap, dash, letterGap,
//                                        dash, gap, dash, gap, dash, letterGap,
//                                        dash, gap, dot, gap, dot]
//        
//        var events = [CHHapticEvent]()
//        var time: Float = 0
//        
//        for duration in veryGoodPattern {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//            
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: TimeInterval(time))
//            events.append(event)
//            
//            time += duration
//        }
//        
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("Failed to play pattern: \(error.localizedDescription).")
//        }
//    }
//    //verygood 모스부호 끝
//    
//    
//    
//    
//
//
//}
