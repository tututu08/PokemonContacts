# PokemonContacts


# 📱 PokemonPhoneBook  
**포켓몬과 함께하는 나만의 연락처 앱**

> Pokémon API와 Core Data를 활용해, 이름과 전화번호를 입력하면 랜덤한 포켓몬 프로필 이미지가 자동으로 매칭되는 감성 가득 연락처 앱입니다.  
> Swift 기반으로 제작되었으며, iOS 기본 UI와 SnapKit으로 깔끔한 레이아웃까지 챙겼습니다.

---

## 🎯 핵심 기능

- **연락처 추가**  
  이름과 전화번호를 입력하고, 한 번의 클릭으로 랜덤한 포켓몬 이미지가 프로필로 지정됩니다.

- **연락처 목록**  
  Core Data에 저장된 연락처를 테이블 뷰에 표시합니다. 이름순 정렬도 지원합니다.

- **랜덤 이미지 생성**  
  Pokémon API에서 랜덤 포켓몬 데이터를 가져와 귀엽고 유니크한 프로필을 생성합니다.

- **데이터 영속성**  
  모든 연락처 정보는 Core Data에 안전하게 저장되어 앱을 껐다 켜도 그대로 유지됩니다.

---

## 🧰 사용 기술 스택

| 구성 요소 | 설명 |
|-----------|------|
| `UIKit` | iOS UI 프레임워크 (ViewController, TableView 등) |
| `SnapKit` | 코드 기반 제약 조건으로 직관적인 UI 레이아웃 구성 |
| `Core Data` | iOS 데이터 저장용 ORM 프레임워크 |
| `URLSession` | Pokémon API를 통한 비동기 데이터 통신 |
| `Pokémon API` | https://pokeapi.co 에서 이미지 및 포켓몬 데이터 제공 |

---

## 🗂️ 앱 구성 구조

- `MainViewController.swift`  
  - 저장된 연락처 목록을 테이블 형식으로 출력  
  - 연락처 추가 버튼 → `AddViewController` 이동  

- `AddViewController.swift`  
  - 이름, 전화번호 입력 필드  
  - "랜덤 이미지 생성" 버튼으로 Pokémon API 호출  
  - Core Data에 정보 저장 후 메인 화면으로 복귀  

- `TableViewCell.swift`  
  - 프로필 이미지, 이름, 전화번호를 시각적으로 표시하는 커스텀 셀 구성  

---

## 🚀 향후 기능 예정 (Optional)

- 연락처 수정 및 삭제 기능 추가 예정  
- 포켓몬 필터 기능 (예: 전설, 타입별 필터링)  
- 이미지 캐싱 및 성능 최적화  

---

## 💡 프로젝트 포인트

- 사용성과 감성을 모두 챙긴 포켓몬 연락처 앱  
- 학습 목적에도 적합한 Core Data 실습 프로젝트  
- URLSession, 비동기 처리, 데이터 바인딩까지 모두 경험 가능  

