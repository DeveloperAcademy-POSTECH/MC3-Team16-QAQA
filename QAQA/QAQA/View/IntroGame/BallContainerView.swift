//
//  BallContainerView.swift
//  QAQA
//
//  Created by 조호식 on 2023/07/24.
//

import SwiftUI
import CoreHaptics

struct BallContainerView: View {
    // 자이로스코프 매니저를 관찰합니다. 이는 공의 움직임에 필요한 가속도 데이터를 제공합니다.
    @ObservedObject var game: RealTimeGame
    @ObservedObject var gyroscopeManager: GyroscopeManager
    
    @StateObject private var reactionSoundViewModel = ReactionSoundViewModel()
    
    // 공의 현재 위치를 나타내는 변수입니다.
    @State private var gyroBallPosition: CGPoint = .zero
    // 공의 현재 속도를 나타내는 변수입니다.
    @State private var gyroVelocity: CGPoint = .zero
    // 공이 원의 테두리에 마지막으로 닿은 시간을 저장하는 변수입니다.
    @State private var gyroLastTouchedBorder: Date? = nil
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
    @State private var gyroRandomTime: Double = 60 //플레이타임
    //    @State private var gyroRandomTime: Double = Double.random(in: 10...20)
    // 랜덤한 시간 간격을 관리하는 타이머입니다.
    @State private var gyroRandomTimer: Timer? = nil
    // 공이 화면에 보이는지 나타내는 변수를 추가합니다.
    @State private var isBallVisible: Bool = true
    // 원의 위치를 나타내는 변수입니다.
    @State private var circlePosition: CGPoint = .zero
    
    //붐쿼카 변수시작
    @State private var gyroCircleImage: String = "success_1"
    @State private var quokkaOpacity: Double = 0.0
    @State private var secondsRemaining: Int = 0
    //붐쿼카 변수 끝
    //    @State var isShowResult = false
    
    
    
    // 공의 움직임에 영향을 주는 가속도 인자입니다.
    let gyroAccelerationFactor: CGFloat = 0.2
    
    var body: some View {
        // GeometryReader를 사용하여 부모 뷰의 크기와 위치에 접근합니다.
        GeometryReader { geometry in
            // ZStack을 사용하여 뷰를 겹칩니다.
            ZStack{
                ZStack {
                    // 배경 이미지를 설정합니다.
                    Image(game.isBombPresent ? self.gyroBackgroundImage : "sky_1")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .onAppear{
                            reactionSoundViewModel.playSound(sound: reactionSoundViewModel.createBoomBgm())
                        }
                    
                    // 원을 그립니다.
                    Image(self.gyroCircleImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .position(self.circlePosition == .zero ?
                                  CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2) :
                                    self.circlePosition)
                    Text("지금 폭탄이 \(game.topicUserName)한테 있어요!")
                        .font(.custom("BMJUAOTF", size: 30))
                        .offset(y: -70)
                    // Quokka 이미지
                    // 공의 움직임을 업데이트하는 타이머를 설정합니다.
                    

                    Ball(gyroImage: self.$gyroBallImage)
                        .opacity(game.isBombPresent ? 1.0 : 0.0)  // 공의 가시성을 설정합니다.
                        .position(self.gyroBallPosition == .zero ?
                                  CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2) :
                                    self.gyroBallPosition)
                    
                        .onAppear {
                            // 뷰가 나타날 때 실행되는 코드입니다.
                            // 햅틱을 준비하고, 공과 원의 초기 위치를 설정하고, 랜덤 타이머를 시작합니다.
                            prepareHaptics()
                            self.gyroBallPosition = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            self.circlePosition = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            self.gyroRandomTimer = Timer.scheduledTimer(withTimeInterval: self.gyroRandomTime, repeats: false) { _ in
                                // 랜덤 타이머가 실행될 때마다 공의 이미지와 배경 이미지를 변경하고, 햅틱 피드백을 제공합니다.
                                // 폭탄이 터진 후의 액션
                                self.gyroBallImage = "boom_2"
                                reactionSoundViewModel.playSound(sound: reactionSoundViewModel.createBoomFanfare(), loop: 0)
                                self.gyroBackgroundImage = "back_2"
                                self.successHaptics()
                                
                                //                                game.createRandomTopicUser(match: game.myMatch!, isMyNameExcluded: true)
                                //                                game.isBombAppear.toggle()
                                //                                game.bombTransport()
                                
                                // 2초 후에 공의 이미지와 배경 이미지를 원래대로 돌리고, 랜덤 시간 간격을 재설정합니다.
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    game.isShowResult.toggle()
                                    //                                    self.gyroBallImage = "boom_1"
                                    //                                    self.gyroBackgroundImage = "back_1"
                                    //                                    self.gyroRandomTime = Double.random(in: 10...20)
                                }
                            }
                            // 공을 그립니다. 공의 위치는 `gyroBallPosition` 변수에 의해 결정됩니다.
                            let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                                if gyroBallImage == "boom_1"{
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
                                    
                                    // 공이 원 안에 있으면 원의 색상을 변경하고, 카운트다운을 시작합니다.
                                    if sqrt(pow(self.gyroBallPosition.x - self.circlePosition.x, 2) + pow(self.gyroBallPosition.y - self.circlePosition.y, 2)) <= 100 {
                                        self.gyroCircleImage = "success_2"
                                        
                                        if let gyroLastTouchedBorder = self.gyroLastTouchedBorder {
                                            // 공이 원의 테두리에 3초 이상 닿아있으면 배경색을 변경하고, 공의 이미지를 변경하고, 햅틱 피드백을 제공합니다.
                                            if gyroLastTouchedBorder.addingTimeInterval(3) <= Date() {
                                                self.gyroLastTouchedBorder = nil
                                                self.successHaptics()
                                                self.gyroCountdownTimer?.invalidate()
                                                self.gyroCountdown = 0
                                                game.createRandomTopicUser(match: game.myMatch!, isMyNameExcluded: true)
                                                game.isBombAppear.toggle()
                                                game.bombTransport()
                                                //
                                                self.gyroLastTouchedBorder = nil
                                                self.gyroCountdownTimer?.invalidate()
                                                self.gyroCountdown = 0
                                                //
                                                gyroBackgroundColor = Color.purple
                                                //                                            self.gyroBallImage = "smile_1"
                                                //                                            self.gyroBackgroundImage = "sky_1"
                                                
                                                self.gyroBallPosition = CGPoint(
                                                    x: CGFloat.random(in: 50...(geometry.size.width - 50)),
                                                    y: CGFloat.random(in: 50...(geometry.size.height - 50))
                                                )
                                                if game.isBombPresent{
                                                    self.circlePosition = CGPoint(
                                                        x: CGFloat.random(in: 50...(geometry.size.width - 50)),
                                                        y: CGFloat.random(in: 50...(geometry.size.height - 50))
                                                    )
                                                }
                                                
                                                // 공을 숨기고 0.5초 후에 랜덤한 위치에 재생성합니다.
                                                //                                            self.isBallVisible = false
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    //                                                self.gyroCircleImage = "success_1"
                                                    //                                                self.isBallVisible = true
                                                    
                                                }
                                                // 2초 후에 공의 이미지와 배경 이미지를 원래대로 돌리고, 랜덤 시간 간격을 재설정합니다.
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                    //                                                self.gyroBallImage = "boom_1"
                                                    //                                                self.gyroBackgroundImage = "back_1"
                                                    //                                                self.gyroRandomTime = Double.random(in: 10...20)
                                                }
                                            }
                                        } else {
                                            // 공이 원의 테두리에 처음 닿을 때 카운트다운을 시작합니다.
                                            self.gyroLastTouchedBorder = Date()
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
                                        self.gyroLastTouchedBorder = nil
                                        self.gyroCountdownTimer?.invalidate()
                                        self.gyroCountdown = 0
                                        gyroCircleColor = Color.white
                                        gyroCircleLineWidth = 2
                                    }
                                }
                                
                            }
                            // 타이머를 실행합니다.
                            RunLoop.current.add(timer, forMode: .common)
                            
                        }
                    
                    // 원 안에 머물러 있는 시간을 화면에 표시합니다.
                    if gyroCountdown > 0 {
                        Text("\(gyroCountdown)")
                            .opacity(game.isBombPresent ? 1 : 0)
                            .font(.system(size: 50, weight: .bold))  // 폰트 크기를 50으로, 볼드체로 변경합니다.
                            .foregroundColor(.gray)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                    
                    if game.isBombPresent {
                        Image("boomQuokka")
                            .resizable()
                            .frame(width: 450, height: 450)
                            .position(x: geometry.size.width - 225, y: geometry.size.height - 225)
                            .opacity(quokkaOpacity)
                        
                    }
                    
                }
                //boomQuokka가 나타나는 카운트다운을 시작합니다.
                
                .onChange(of: game.isBombAppear, perform: { _ in
                    game.bombTransport()
                    if game.myName == game.topicUserName {
                        game.isBombPresent = true
                    } else {
                        game.isBombPresent = false
                    }
                })
                .onAppear(){
                    changeImageWithCountdown()
                    game.createRandomTopicUser(match: game.myMatch!)
                    game.bombTransport()
//                    if game.myName == game.topicUserName {
//                        game.isBombPresent = true
//                    } else {
//                        game.isBombPresent = false
//                    }
                }
                if game.isShowResult{
                    IntroResultView(game: game)
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
            print("햅틱 엔진 생성 중 오류 발생: \(error.localizedDescription)")
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
            print("패턴 재생 실패: \(error.localizedDescription).")
        }
    }
    //최초 설정된 폭탄의 랜덤시간을 기준으로 폭탄폭발이 10초 남았을때 부터 붐쿼카가 나타납니다.
    private func changeImageWithCountdown() {
        if self.gyroBackgroundImage != "sky_1" {
            self.gyroBallImage = "boom_1"
            self.secondsRemaining = Int(self.gyroRandomTime)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.secondsRemaining > 0 {
                    self.secondsRemaining -= 1
                    if self.secondsRemaining <= 10 {
                        self.quokkaOpacity += 0.07
                        if self.quokkaOpacity >= 0.7 {
                            self.quokkaOpacity = 0.7
                        }
                    }
                } else {
                    self.gyroBallImage = "boom_2"
                    timer.invalidate()
                }
            }
        }
    }
}

//struct BallContainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        BallContainerView(game: RealTimeGame(), gyroscopeManager: GyroscopeManager())
//    }
//}
