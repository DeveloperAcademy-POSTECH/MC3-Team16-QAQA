//
//  HapticMotion.swift
//  HapticTest
//
//  Created by 조호식 on 2023/07/17.
//

import CoreHaptics
import CoreMotion

class HapticMotion: ObservableObject {
    // Your existing code...
    
    private var motionManager: CMMotionManager?
    private var hapticEngine: CHHapticEngine?

    init() {
        // Your existing initialization code...

        // CoreMotion을 초기화합니다.
        motionManager = CMMotionManager()
        motionManager?.accelerometerUpdateInterval = 0.2

        // Haptic Engine을 초기화합니다.
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Haptic Engine을 생성하지 못했습니다: \(error)")
        }

        // 가속도계의 업데이트를 시작합니다.
        startAccelerometerUpdates()
    }

    func startAccelerometerUpdates() {
        guard let motionManager = motionManager, motionManager.isAccelerometerAvailable else {
            return
        }

        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [weak self] (data, error) in
            guard let data = data else { return }
            
            // 임의의 가속도 임계값을 설정합니다.
            let threshold: Double = 1

            if abs(data.acceleration.x) > threshold ||
               abs(data.acceleration.y) > threshold ||
               abs(data.acceleration.z) > threshold {
                self?.playHapticFeedback()
            }
        }
    }

    func playHapticFeedback() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }

        do {
            let pattern = try CHHapticPattern(events: [
                CHHapticEvent(eventType: .hapticTransient, parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
                ], relativeTime: 0, duration: 1)
            ], parameters: [])

            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Haptic feedback을 재생하지 못했습니다: \(error)")
        }
    }
}
