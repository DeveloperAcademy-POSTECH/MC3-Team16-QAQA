//
//  HapticFeedbackManager.swift
//  QAQA
//
//  Created by 조호식 on 2023/07/16.
//

// SwiftUI, CoreHaptics, UIKit을 import합니다.
// CoreHaptics는 고급 햅틱 피드백을 생성하기 위한 프레임워크이며,
// UIKit는 알림 햅틱을 생성하기 위한 프레임워크입니다.
import SwiftUI
import CoreHaptics
import UIKit

// HapticFeedbackManager 클래스는 햅틱 피드백을 관리합니다.
class HapticFeedbackManager: ObservableObject {
    // CHHapticEngine 인스턴스를 저장합니다.
    // 이 엔진은 햅틱 피드백 이벤트를 생성하고 재생하는데 사용됩니다.
    private var engine: CHHapticEngine?
    
    // 생성자에서는 햅틱 지원 여부를 체크하고, 엔진을 초기화하며 시작합니다.
    init() {
        // 현재 장치가 햅틱 기능을 지원하는지 확인합니다.
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            // 엔진을 초기화하고 시작합니다.
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            // 에러가 발생하면 콘솔에 출력합니다.
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    // 햅틱 피드백 이벤트를 생성하고 재생합니다.
    // 이 메소드는 강도(float 형식)의 배열을 인자로 받아, 각 강도에 해당하는 진동을 순차적으로 재생합니다.
    func generateHapticFeedback(intensities: [Float]) {
        // 다시 한 번 햅틱 지원 여부를 확인합니다.
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        // 이벤트를 저장할 배열을 초기화합니다.
        var events = [CHHapticEvent]()
        // 강도 배열의 각 원소에 대해 반복하며, 해당 강도의 진동 이벤트를 생성합니다.
        for (i, intensity) in intensities.enumerated() {
            // 강도와 날카로움 파라미터를 설정합니다. 두 파라미터 모두 강도 값을 사용합니다.
            let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
            let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness, value: intensity)
            // 이벤트를 생성합니다. 각 이벤트는 0.1초 간격으로 순차적으로 재생됩니다.
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParameter, sharpnessParameter], relativeTime: Double(i) * 0.1)
            events.append(event)
        }
        
        do {
            // 이벤트 배열을 바탕으로 패턴을 생성하고, 이 패턴을 재생하는 플레이어를 생성합니다.
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            // 플레이어를 즉시 시작하여 햅틱 피드백을 재생합니다.
            try player?.start(atTime: 0)
        } catch {
            // 에러가 발생하면 콘솔에 출력합니다.
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
    
    // 알림 햅틱 피드백을 생성하고 재생하는 메소드입니다.
    // 기본값으로 성공(success) 알림을 재생하지만, 다른 알림 유형을 인자로 전달하여 해당 알림을 재생할 수 있습니다.
    func generateNotificationFeedback(type: UINotificationFeedbackGenerator.FeedbackType = .success) {
        // UINotificationFeedbackGenerator 인스턴스를 생성합니다.
        let generator = UINotificationFeedbackGenerator()
        // 알림 햅틱을 재생합니다.
        generator.notificationOccurred(type)
    }
}

// HapticButton 뷰는 햅틱 피드백을 재생하는 버튼입니다.
struct HapticButton: View {
    // 라벨, 강도 배열, 알림 유형을 저장하는 프로퍼티를 정의합니다.
    var label: String
    var intensities: [Float]
    var notificationType: UINotificationFeedbackGenerator.FeedbackType?
    // HapticFeedbackManager 인스턴스를 @StateObject 속성으로 저장합니다.
    // 이 인스턴스는 버튼의 햅틱 피드백을 관리합니다.
    @StateObject var hapticFeedbackManager = HapticFeedbackManager()
    
    // 뷰의 body에서는 버튼을 생성하고, 버튼 클릭 시 햅틱 피드백을 재생하는 액션을 설정합니다.
    var body: some View {
        Button(action: {
            // 알림 유형이 설정되어 있으면, 해당 알림 햅틱을 재생합니다.
            if let notificationType = notificationType {
                hapticFeedbackManager.generateNotificationFeedback(type: notificationType)
            } else {
                // 알림 유형이 설정되어 있지 않으면, 강도 배열을 바탕으로 햅틱 피드백을 재생합니다.
                hapticFeedbackManager.generateHapticFeedback(intensities: intensities)
            }
        }) {
            // 버튼의 라벨을 설정합니다.
            Text(label)
                // 라벨에 패딩을 추가하고, 배경색을 파란색으로 설정합니다.
                .padding()
                .background(Color.blue)
                // 글자색을 흰색으로 설정합니다.
                .foregroundColor(.white)
                // 버튼 모서리를 둥글게 만듭니다.
                .cornerRadius(10)
        }
    }
}
