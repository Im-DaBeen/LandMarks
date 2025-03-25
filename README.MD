# 👤 Face Tracking ARKit App (with RealityKit)

## 📌 프로젝트 개요

이 프로젝트는 **iPhone의 TrueDepth 카메라를 활용한 얼굴 추적(Face Tracking)** 기능을 구현하는 **ARKit 기반 iOS 앱**입니다.  
`RealityKit`을 활용해 3D 모델(`.usdz`)을 얼굴에 오버레이하여 증강현실 효과를 구현합니다.

- **기술 스택**: Swift, SwiftUI, ARKit, RealityKit
- **지원 기기**: iPhone X 이상 (Face ID 지원 기기)
- **주요 기능**:
  - 얼굴 인식(FaceAnchor)을 통한 실시간 추적
  - `.usdz` 형식의 3D 모델을 얼굴에 부착
  - SwiftUI + UIViewControllerRepresentable 연동

---

## ✅ 프로젝트 진행 상황

### 1. 프로젝트 세팅
- [x] Xcode 프로젝트 생성 (`App` 템플릿 + SwiftUI)
- [x] `RealityKit`, `ARKit` 프레임워크 추가
- [x] iPhone 실기기 연동 및 테스트 환경 설정
- [x] Bundle Identifier 변경 및 Apple ID 연결
- [x] 코드 서명 및 프로비저닝 프로파일 설정 완료

### 2. Face Tracking 구현
- [x] `ARFaceTrackingConfiguration`을 활용한 얼굴 추적 구현
- [x] RealityKit을 통해 3D 모델 오버레이
- [x] ARView 세팅 및 AnchorEntity(face) 구성

### 3. Info.plist 설정
- [x] `NSCameraUsageDescription` 추가
- [x] `ARKitFaceTrackingUsageDescription` 추가

### 4. 실기기 테스트
- [x] iPhone 개발자 신뢰 설정 (`설정 > 일반 > VPN 및 기기 관리`)
- [x] 앱 실행 시 3D 모델 로딩 확인
- [x] 문제 발생 시: 프로비저닝 프로파일 삭제 및 재설정
- [x] 리소스 부족/플러그인 인터페이스 오류 해결

### 5. 3D 모델 (.usdz) 관련
- [x] `.usdz` 파일은 단순한 확장자 변경이 아닌 변환 필요
- [x] Reality Converter로 `.usdz` 생성 및 추가
- [x] Xcode 프로젝트에 올바르게 파일 포함 및 로딩 확인

---

## ⚠️ 주요 이슈 & 해결 방법

| 문제 | 해결 방법 |
|------|-----------|
| 앱 실행 후 Face Tracking 작동 안됨 | 기기 지원 여부 확인 (iPhone X 이상), Info.plist 설정, 권한 허용 |
| 3D 모델을 찾을 수 없음 (`Entity.load(named:)`) | `.usdz` 파일 유효성 확인, RealityKitContent에 정확하게 추가 |
| Unable to verify app | iPhone에서 인터넷 연결 후 개발자 인증서 신뢰 설정 필요 |
| Invalid package format 오류 | `.usdz` 파일이 단순 확장자 파일이 아닌지 확인, Reality Converter로 변환(진행중)| 
| 코드 서명 오류 | `Automatically manage signing` 체크, 프로비저닝 프로파일 재설정 |

---

## 📂 파일 구조
```text
Landmarks/
├── LandmarksApp.swift
├── ContentView.swift
├── FaceTrackingView.swift
├── RealityKitContent/
│   └── face_mask.usdz
├── Assets.xcassets
├── Info.plist

---

## 문제상황과 앞으로의 방향
- reality kit를 통한 .usdz 파일 만들어야 카메라 화면에 3d 모델 구현되는 것으로 생각하였음
- 그러나 ARKit만으로도 충분히 구현 가능한 것으로 판단
- 화면에 ARkit 구현하고 감정분석 가능하도록 얼굴 메쉬 포인트 데이터 주고받는 부분 확인할 것
- 이후 감정분석을 위한 로직 구현하기

---

## 🔄 방향 전환: RealityKit 제거 & ARKit 기반 감정 분석
- 기존 프로젝트는 RealityKit 기반 3D 모델 오버레이 목적이었으나, 본래 목적은 실시간 감정 분석.
- RealityKit은 제거하고, ARKit 단독으로 ARSCNView + ARFaceAnchor.blendShapes를 활용
- 주요 감정(행복, 놀람, 화남 등)을 분류하고 Console에 출력하는 구조로 변경



---


