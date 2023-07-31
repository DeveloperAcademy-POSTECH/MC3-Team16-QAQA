//
//  tutorialView.swift
//  QAQA
//
//  Created by 박진영 on 2023/07/30.
//

import SwiftUI

struct tutorialView: View {
    
    @State private var pageNum = 1
    var body: some View {
        TabView(selection: $pageNum) {
            FirstOnBoardingView(pageNum: $pageNum)
                .tag(1)
            SecondOnBoardingView(pageNum: $pageNum)
                .tag(2)
            ThirdOnBoardingView()
                .tag(3)
            
        }
        .ignoresSafeArea()
        .animation(.easeInOut, value: pageNum)
        .transition(.slide)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .navigationBarHidden(true)
    }
}

struct FirstOnBoardingView: View {
    @Binding var pageNum: Int
    var body: some View {
        
        VStack {
            Image("bombQuokka")
                .resizable()
                .scaledToFit()
                .frame(width: 358)
                .padding(.bottom, 42)
            Text("주인공을 선정하세요")
                .font(.custom("BMJUAOTF", size: 27))
                .padding(.bottom, 15)
            Text("폭탄돌리기 게임을 통해\n분위기를 재미있게 풀어보세요!\n폭탄이 터지는 순간 오늘의 주인공이 정해져요!")
                .font(.custom("BMJUAOTF", size: 18))
                .foregroundColor(Color.gray)
                .lineSpacing(2.5)
                .multilineTextAlignment(.center)
                .padding(.bottom, 32)
            Button {
                pageNum = 2
            } label: {
                
                ZStack {
                    Image("tutorialViewButton_Yellow")
                    Text("다음")
                        .font(.custom("BMJUAOTF", size: 17))
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                }
                
            }
        }
        .navigationBarHidden(true)
    }
}

struct SecondOnBoardingView: View {
    @Binding var pageNum: Int
    var body: some View {
        
        VStack {
            Image("talkingQuokka")
                .resizable()
                .scaledToFit()
                .frame(width: 358)
                .padding(.bottom, 42)
            Text("질문폭격 세션")
                .font(.custom("BMJUAOTF", size: 27))
                .padding(.bottom, 15)
            Text("오늘의 주인공에게\n10분간 질문폭격을 퍼부어주세요.\n버튼으로 재미있는 리액션을 할 수 있습니다.")
                .font(.custom("BMJUAOTF", size: 18))
                .foregroundColor(Color.gray)
                .lineSpacing(2.5)
                .multilineTextAlignment(.center)
                .padding(.bottom, 32)
            Button {
                pageNum = 3
            } label: {
                
                ZStack {
                    Image("tutorialViewButton_Yellow")
                    Text("다음")
                        .font(.custom("BMJUAOTF", size: 17))
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                }
                
            }
        }
        
    }
}

struct ThirdOnBoardingView: View {
    
    @State var isShowingHomeView = false
    
    var body: some View {
        ZStack {
            VStack {
                Image("resultQuokka")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 358)
                    .padding(.bottom, 42)
                Text("결과를 확인하세요!")
                    .font(.custom("BMJUAOTF", size: 27))
                    .padding(.bottom, 15)
                Text("질문을 끝내고\n리액션을 많이 한 사람을 확인하세요!\n")
                    .font(.custom("BMJUAOTF", size: 18))
                    .foregroundColor(Color.gray)
                    .lineSpacing(2.5)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                Button {
                    isShowingHomeView.toggle()
                } label: {
                    ZStack {
                        Image("tutorialViewButton_Yellow")
                        Text("팀원 찾으러가기")
                            .font(.custom("BMJUAOTF", size: 17))
                            .foregroundColor(.black)
                            .padding(.bottom, 5)
                    }
                }
            }
            if (isShowingHomeView) {
                    HomeView()
            }
        }
    }
}


struct tutorialView_Previews: PreviewProvider {
    static var previews: some View {
        tutorialView()
    }
}
