//
//  GyroscopeManager.swift
//  QAQA
//
//  Created by 조호식 on 2023/07/24.
//

import CoreMotion

// GyroscopeManager 클래스를 선언합니다. 이 클래스는 SwiftUI의 ObservableObject 프로토콜을 따릅니다.
class GyroscopeManager: ObservableObject {
    // CMMotionManager 인스턴스를 gyroMotionManager라는 이름의 비공개 변수로 선언합니다.
    private var gyroMotionManager: CMMotionManager
    
    // x축 가속도와 y축 가속도를 나타내는 공개 변수를 선언합니다. 이 변수들은 @Published 속성 래퍼를 사용하여 선언되었으므로,
    // 해당 변수들의 값이 변경될 때마다 이 클래스를 구독하는 SwiftUI 뷰는 새로 고쳐집니다.
    @Published var gyroXAcceleration: Double
    @Published var gyroYAcceleration: Double

    // GyroscopeManager 클래스의 생성자를 선언합니다.
    init() {
        // CMMotionManager 인스턴스를 생성하여 gyroMotionManager 변수에 할당합니다.
        self.gyroMotionManager = CMMotionManager()
        
        // x축 가속도와 y축 가속도를 0.0으로 초기화합니다.
        self.gyroXAcceleration = 0.0
        self.gyroYAcceleration = 0.0
        
        // 가속도계를 시작합니다.
        gyroStartAccelerometer()
    }

    // 가속도계를 시작하는 함수를 선언합니다.
    func gyroStartAccelerometer() {
        // 장치가 가속도계를 지원하는 경우에만 가속도계 업데이트를 시작합니다.
        if gyroMotionManager.isAccelerometerAvailable {
            // 가속도계의 업데이트 주기를 1/120초로 설정합니다. 즉, 가속도계는 매 초당 120번의 업데이트를 제공합니다.
            self.gyroMotionManager.accelerometerUpdateInterval = 1.0 / 120.0
            
            // 가속도계 업데이트를 시작합니다. 이때, 가속도 데이터는 메인 큐에 전달됩니다.
            self.gyroMotionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                // 가속도 데이터가 존재하는 경우에만 이어서 처리합니다.
                if let myData = data {
                    // 가속도 데이터를 메인 큐에서 처리합니다. 이로써 UI와 관련된 작업을 안전하게 수행할 수 있습니다.
                    DispatchQueue.main.async {
                        // 가속도 데이터를 xAcceleration과 yAcceleration 변수에 할당합니다.
                        self.gyroXAcceleration = myData.acceleration.x
                        self.gyroYAcceleration = myData.acceleration.y
                    }
                }
            }
        }
    }
}


