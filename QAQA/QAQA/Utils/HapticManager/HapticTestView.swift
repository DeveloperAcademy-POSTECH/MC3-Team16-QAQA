//
//  HapticTestView.swift
//  QAQA
//
//  Created by 조호식 on 2023/07/16.
//

import SwiftUI

// HapticTestView는 여러 햅틱 피드백을 재생하는 버튼들을 보여주는 뷰입니다.
struct HapticTestView: View {
    var body: some View {
        // VStack을 사용하여 수직으로 여러 버튼들을 배열합니다.
        VStack {
            // 각각 다른 햅틱 피드백을 재생하는 HapticButton들을 생성합니다.
            
            // 강도가 1.0인 진동을 한 번 재생하는 버튼
            HapticButton(label: "Button 1", intensities: [1.0])
            // 강도가 0.8인 진동을 두 번 재생하는 버튼
            HapticButton(label: "Button 2", intensities: [0.8, 0.8])
            // 강도가 0.6인 진동을 세 번 재생하는 버튼
            HapticButton(label: "Button 3", intensities: [0.6, 0.6, 0.6])
            // '성공' 알림 햅틱을 재생하는 버튼
            HapticButton(label: "Success Button", intensities: [], notificationType: .success)
            // '경고' 알림 햅틱을 재생하는 버튼
            HapticButton(label: "Warning Button", intensities: [], notificationType: .warning)
            // '오류' 알림 햅틱을 재생하는 버튼
            HapticButton(label: "Error Button", intensities: [], notificationType: .error)
        }
    }
}

// 미리보기를 제공하는 프로토콜 PreviewProvider를 준수하는 구조체입니다.
struct HapticTestView_Previews: PreviewProvider {
    // 미리보기를 위한 뷰를 반환하는 previews 속성을 정의합니다.
    // 이 경우 HapticTestView를 미리보기 뷰로 사용합니다.
    static var previews: some View {
        HapticTestView()
    }
}
