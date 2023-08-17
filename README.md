# MC3-Team16-QAQA

<div align="center">
  
 ### _**☘️✨ QAQA ✨☘️**_
 _**끈끈한 팀빌딩을 위한, 팀원들이 서로 잘 알아가도록 돕는 질문폭격 애플리케이션**_ 
 
 </div>
 
 
### [💛 About QAQA](https://www.notion.so/QAQA-639ebc9294b043c3a4bc9ba4aead811f?pvs=4)
> 📅 프로젝트 기간: 2023.06.19 - 2023.08.04<br>


QAQA는 팀원 중 한 사람을 지정하여 질문폭격을 할 수 있도록 돕는 앱입니다.<br>
하루 10분, 팀원들과 재미있는 질의응답으로 서로에 대해 더 잘 이해할 수 있습니다.<br>
우리 팀 멤버가 어떤 질문을 하고 어떻게 반응하는 지를 지켜보면서 말이에요!
<br>
<br>
 
 ### 🧑‍💻 Authors
> 웃-쨔쾌감마스터즈 (a.k.a 웃쾌마 🤣)

<details>
<summary>✨ Role</summary>
<div>

- West: `GameCenter`, `Tech Leader`
- Molly: `View`, `Data Link`
- Kiyoung: `Timer`, `Data Link`
- Joy: `Intro Game`, `Haptic`
- Claudia: `UI Design`, `Onboarding View`
- Flynn: `UX`, `Project Managing`


</div>
</details>

|[<img src="https://github.com/kpk0616.png" width="100px">](https://github.com/kpk0616)|[<img src="https://github.com/hyelinkim.png" width="100px">](https://github.com/hyelinkim)|[<img src="https://github.com/Kiyoung-Kim-57.png" width="100px">](https://github.com/Kiyoung-Kim-57)|[<img src="https://github.com/Joy19061618.png" width="100px">](https://github.com/Joy19061618)|[<img src="https://github.com/Claudia323.png" width="100px">](https://github.com/Claudia323)|[<img src="https://github.com/dev-minseo.png" width="100px">](https://github.com/dev-minseo)|  
|:----:|:----:|:----:|:----:|:----:|:----:|
|[West](https://github.com/kpk0616)|[Molly](https://github.com/hyelinkim)|[Kiyoung](https://github.com/Kiyoung-Kim-57)|[Joy](https://github.com/Joy19061618)|[Claudia](https://github.com/Claudia323)|[Flynn](https://github.com/dev-minseo)|
<br>

 ### 📱 Screenshots
 업로드 예정입니다.
|Onboarding|Initial Setting|Setting|
|:-:|:-:|:-:|
<br>

---
### 🛠 Development Environment
<img width="80" src="https://img.shields.io/badge/IOS-16%2B-silver"> <img width="95" src="https://img.shields.io/badge/Xcode-14.3-blue">
<br>

### :sparkles: Skills & Tech Stack
* SwiftUI
* Code base
* Game Center
* Haptic
* Timer
* Sound
<br>

### 🎁 Library
```swift
import SwiftUI
import UIKit
import CoreMotion
import GameKit
```
<br>

### 🗂 Folder Structure
```swift
QAQA
├── Model
│   ├── Game
│   ├── Outro
│   ├── Question
│   ├── Reaction
│   └── Timer
├── Preview Content
├── Resources
│   ├── Assets
│   │   └── Color
│   │   └── Images
│   └── Lotties
├── Utils
│   ├── Color
│   ├── Font
│   ├── GameCenter
│   ├── Gyroscopes
│   ├── ReactionModifier
│   ├── Sounds
│   └── UIScreen
├── View
│   ├── Home
│   ├── Intro
│   ├── IntroGame
│   ├── Outro
│   ├── Question
│   ├── Test
│   └── Timer
└── ViewModel
```
<br>
 
### 🔀 Git branch & Git Flow
1. Git Convention
  - `[Hotfix]` : issue나, QA에서 급한 버그 수정에 사용
  - `[Fix]` : 버그, 오류 해결
  - `[Add]` : Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시
  - `[Style]` : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
  - `[Feat]` : 새로운 기능 구현
  - `[Del]` : 쓸모없는 코드 삭제
  - `[Docs]` : README나 WIKI 등의 문서 개정
  - `[Chore]` : 코드 수정, 내부 파일 수정, 빌드 업무 수정, 패키지 매니저 수정
  - `[Correct]` : 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용합니다.
  - `[Move]` : 프로젝트 내 파일이나 코드의 이동
  - `[Rename]` : 파일 이름 변경이 있을 때 사용합니다.
  - `[Refactor]` : 전면 수정이 있을 때 사용합니다
  - `[Init]` : Initial Commit
2. Branch 전략
  - `main` : 개발이 완료된 산출물이 저장될 공간
  - `develop` : feature 브랜치에서 구현된 기능들이 merge될 브랜치
  - `feature` : 기능을 개발하는 브랜치, 이슈별/작업별로 브랜치를 생성하여 기능을 개발한다
  - `release` : 릴리즈를 준비하는 브랜치, 릴리즈 직전 QA 기간에 사용한다
  - `hotfix` : 버그를 수정하는 브랜치
<br>

### :lock_with_ink_pen: License
<img width="100" src="https://img.shields.io/badge/MIT License-2.0-yellow">
<br><br>
