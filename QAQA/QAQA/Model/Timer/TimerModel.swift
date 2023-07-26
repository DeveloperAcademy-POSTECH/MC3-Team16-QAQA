//
//  TimerModel.swift
//  QAQA
//
//  Created by 김기영 on 2023/07/12.
//

import Foundation
import SwiftUI

class TimerModel: ObservableObject {
//    @Published var countMin = 10
//    @Published var countSecond = 0
//    @Published var isTimer = true
//    @Published var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
//
//    func displayTime(_ isCount:Bool = true) -> some View{ //아규먼트 값이 true면은 카운트가 되는 시간이고(TimerView에 적용) false면은 단순히 TimerModel에서 변수만 받아와서 시간만 표기하는 함수(TimerModalView에 적용), .onReceive를 실행하는냐 아니냐의 차이
//        if isCount == true {
//            if countSecond < 10 {
//                return  Text("\(self.countMin):0\(countSecond)")
//                    .onReceive(timer , perform: {(_) in
////                        print("\(self.countMin), \(self.countSecond)")
//                        if self.isTimer {
//                            if self.countSecond == 0 {
//                                if self.countMin == 0 {
//                                    self.isTimer = false
//                                    return
//                                }
//                                self.countMin -= 1
//                                self.countSecond = 59
//                            }
//                            else {
//                                self.countSecond -= 1
//                            }
//                        }
//                    })
//            }
//            else
//            {
//              return  Text("\(countMin):\(countSecond)")
//                    .onReceive(timer , perform: {(_) in
////                        print("\(self.countMin), \(self.countSecond)")
//                        if self.isTimer {
//                            if self.countSecond == 0 {
//                                if self.countMin == 0 {
//                                    self.isTimer = false
//                                    return
//                                }
//                                self.countMin -= 1
//                                self.countSecond = 59
//                            }
//                            else {
//                                self.countSecond -= 1
//                            }
//                        }
//                    })
//            }
//        } else {
//            if countSecond < 10 {
//                return  Text("\(self.countMin):0\(countSecond)")
//                    .onReceive(timer , perform: { _ in })
//            }
//            else
//            {
//              return  Text("\(countMin):\(countSecond)")
//                    .onReceive(timer , perform: { _ in })
//            }
//        }
//    }
}
