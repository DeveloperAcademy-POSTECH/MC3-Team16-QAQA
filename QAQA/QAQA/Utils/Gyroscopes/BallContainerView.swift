//
//  BallContainerView.swift
//  QAQA
//
//  Created by 조호식 on 2023/07/24.
//

import SwiftUI
import CoreHaptics

// BallContainerView는 공의 움직임을 다루는 뷰입니다.
struct BallContainerView: View {
    // gyroscopeManager를 관찰하고 있습니다. 이것은 공의 움직임에 필요한 가속도 데이터를 제공합니다.
    @ObservedObject var gyroscopeManager: GyroscopeManager

    // 공의 현재 위치를 나타내는 변수입니다.
    @State private var gyroBallPosition: CGPoint = .zero
    // 공의 현재 속도를 나타내는 변수입니다.
    @State private var gyroVelocity: CGPoint = .zero
    // 공이 중심에 마지막으로 진입한 시간을 저장하는 변수입니다.
    @State private var gyroLastEnteredCenter: Date? = nil
    // 햅틱 엔진에 대한 참조를 저장하는 변수입니다.
    @State private var gyroEngine: CHHapticEngine?
    // 원 안에 공이 머물러 있는 시간을 계산하는 카운트다운을 나타내는 변수입니다.
    @State private var gyroCountdown: Int = 0
    // 카운트다운을 관리하는 타이머입니다.
    @State private var gyroCountdownTimer: Timer? = nil
    // 원의 색상을 나타내는 변수입니다.
    @State private var gyroCircleColor: Color = Color.white
    // 원의 선 두께를 나타내는 변수입니다.
    @State private var gyroCircleLineWidth: CGFloat = 2
    // 배경색상을 나타내는 변수입니다.
    @State private var gyroBackgroundColor: Color = Color.black

    // 공의 이미지를 나타내는 변수입니다.
    @State private var gyroBallImage: String = "boom_1"
    // 배경 이미지를 나타내는 변수입니다.
    @State private var gyroBackgroundImage: String = "back_1"

    // 랜덤한 시간 간격을 나타내는 변수입니다.
    @State private var gyroRandomTime: Double = Double.random(in: 10...20)
    // 랜덤한 시간 간격을 관리하는 타이머입니다.
    @State private var gyroRandomTimer: Timer? = nil

    // 공의 움직임에 영향을 주는 가속도 인자입니다.
    let gyroAccelerationFactor: CGFloat = 0.2

    // 뷰의 본문을 정의하는 부분입니다.
    var body: some View {
        // GeometryReader를 사용하여 부모 뷰의 크기와 위치에 접근합니다.
        GeometryReader { geometry in
            // ZStack을 사용하여 뷰를 겹칩니다.
            ZStack {
                // 배경 이미지를 설정합니다.
                Image(self.gyroBackgroundImage)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)

                // 원을 그립니다.
                Circle()
                    .stroke(gyroCircleColor, lineWidth: gyroCircleLineWidth)
                    .frame(width: 100, height: 100)

                // 공을 그립니다.
                Ball(gyroImage: self.$gyroBallImage)
                    // 공의 위치를 설정합니다.
                    .position(self.gyroBallPosition == .zero ?
                              CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2) :
                              self.gyroBallPosition)
                    // 뷰가 나타날 때 실행되는 코드입니다.
                    .onAppear {
                        // 햅틱을 준비하고, 공의 초기 위치를 설정하고, 랜덤 타이머를 시작합니다.
                        prepareHaptics()
                        self.gyroBallPosition = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        self.gyroRandomTimer = Timer.scheduledTimer(withTimeInterval: self.gyroRandomTime, repeats: true) { _ in
                            // 랜덤 타이머가 실행될 때마다 공의 이미지와 배경 이미지를 변경하고, 햅틱 피드백을 제공합니다.
                            self.gyroBallImage = "boom_2"
                            self.gyroBackgroundImage = "back_2"
                            self.successHaptics()

                            // 2초 후에 공의 이미지와 배경 이미지를 원래대로 돌리고, 랜덤 시간 간격을 재설정합니다.
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.gyroBallImage = "boom_1"
                                self.gyroBackgroundImage = "back_1"
                                self.gyroRandomTime = Double.random(in: 10...20)
                            }
                        }

                        // 공의 움직임을 업데이트하는 타이머를 설정합니다.
                        let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                            // 새로운 속도와 위치를 계산합니다.
                            var newVelocity = CGPoint(
                                x: self.gyroVelocity.x + gyroAccelerationFactor * CGFloat(self.gyroscopeManager.gyroXAcceleration),
                                y: self.gyroVelocity.y - gyroAccelerationFactor * CGFloat(self.gyroscopeManager.gyroYAcceleration)
                            )
                            let newPosition = CGPoint(
                                x: self.gyroBallPosition.x + self.gyroVelocity.x,
                                y: self.gyroBallPosition.y + self.gyroVelocity.y
                            )

                            // 공이 화면을 벗어나지 않도록 속도를 조정합니다.
                            if newPosition.x < 50 || newPosition.x > geometry.size.width - 50 {
                                newVelocity.x = 0
                            }
                            if newPosition.y < 50 || newPosition.y > geometry.size.height - 50 {
                                newVelocity.y = 0
                            }
                            self.gyroVelocity = newVelocity

                            // 공이 화면을 벗어나지 않도록 위치를 조정합니다.
                            if newPosition.x >= 50 && newPosition.x <= geometry.size.width - 50 {
                                self.gyroBallPosition.x = newPosition.x
                            }
                            if newPosition.y >= 50 && newPosition.y <= geometry.size.height - 50 {
                                self.gyroBallPosition.y = newPosition.y
                            }

                            // 공이 원 안에 있으면 원의 색상과 두께를 변경하고, 카운트다운을 시작합니다.
                            if sqrt(pow(self.gyroBallPosition.x - geometry.size.width / 2, 2) + pow(self.gyroBallPosition.y - geometry.size.height / 2, 2)) <= 100 {
                                gyroCircleColor = Color.blue
                                gyroCircleLineWidth = 8

                                if let gyroLastEnteredCenter = self.gyroLastEnteredCenter {
                                    // 공이 원 안에 3초 이상 머물렀으면 배경색을 변경하고, 공의 이미지를 변경하고, 햅틱 피드백을 제공합니다.
                                    if gyroLastEnteredCenter.addingTimeInterval(3) <= Date() {
                                        self.gyroLastEnteredCenter = nil
                                        self.successHaptics()
                                        self.gyroCountdownTimer?.invalidate()
                                        self.gyroCountdown = 0

                                        gyroBackgroundColor = Color.purple
                                        self.gyroBallImage = "smile_1"
                                        self.gyroBackgroundImage = "sky_1"
                                        // 2초 후에 공의 이미지와 배경 이미지를 원래대로 돌리고, 랜덤 시간 간격을 재설정합니다.
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            self.gyroBallImage = "boom_1"
                                            self.gyroBackgroundImage = "back_1"
                                            self.gyroRandomTime = Double.random(in: 10...20)
                                        }
                                    }
                                } else {
                                    // 공이 원 안에 처음 들어올 때 카운트다운을 시작합니다.
                                    self.gyroLastEnteredCenter = Date()
                                    self.gyroCountdown = 3
                                    self.gyroCountdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                        self.gyroCountdown -= 1
                                        if self.gyroCountdown <= 0 {
                                            self.gyroCountdownTimer?.invalidate()
                                        }
                                    }
                                }
                            } else {
                                // 공이 원을 벗어나면 카운트다운을 중지하고, 원의 색상과 두께를 원래대로 돌립니다.
                                self.gyroLastEnteredCenter = nil
                                self.gyroCountdownTimer?.invalidate()
                                self.gyroCountdown = 0
                                gyroCircleColor = Color.white
                                gyroCircleLineWidth = 2
                            }
                        }
                        // 타이머를 실행합니다.
                        RunLoop.current.add(timer, forMode: .common)
                    }

                // 원 안에 머물러 있는 시간을 화면에 표시합니다.
                if gyroCountdown > 0 {
                    Text("\(gyroCountdown)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
        }
    }

    // 햅틱 엔진을 준비하는 함수입니다.
    func prepareHaptics() {
        // 햅틱을 지원하는지 확인합니다.
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            // 햅틱 엔진을 생성하고 시작합니다.
            self.gyroEngine = try CHHapticEngine()
            try gyroEngine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    // 성공한 햅틱 피드백을 제공하는 함수입니다.
    func successHaptics() {
        // 햅틱을 지원하는지 확인합니다.
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        // 햅틱 이벤트를 생성합니다.
        var events = [CHHapticEvent]()

        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)

        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 1)
        events.append(event)

        do {
            // 햅틱 패턴을 생성하고 재생합니다.
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try gyroEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}
