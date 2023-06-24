# Will Grow(윌 그로우)
기분 일기는 일상 속에서의 감정을 기록하고, 다짐을 담은 한 문장을 작성하여 자신의 감정과 성장을 추적하는데 도움을 주는 어플입니다. 매일 일기를 작성하고 감정 변화를 시각화하여 개인적인 성장을 이룰 수 있습니다. 목표를 홈화면 위젯에 업데이트 해주며 반복적으로 목표를 상기할 수 있도록 도움을 줍니다. 당신의 더 나은 하루를 함께 만들어가요.


## 앱 소개
<img width="1182" alt="스크린샷 2023-06-24 오후 6 46 39" src="https://github.com/Jun-Jinu/-Will-Grow-Widget-App/assets/81470586/a652ce7c-1115-4fc3-b041-b566f5381bc8">
<br /> <br />
<img width="1261" alt="스크린샷 2023-06-24 오후 6 47 56" src="https://github.com/Jun-Jinu/-Will-Grow-Widget-App/assets/81470586/b9aeb0ec-b29e-44bb-9ebc-39f6081404a3">
<br /> <br />



## 기술 스택
- Flutter: 앱의 기본 토대는 크로스플랫폼 flutter로 만들어졌습니다.
- Swift(Widgetkit): IOS 홈 화면 위젯 개발에 사용되었습니다.

## 사용된 주요 패키지
- Provider: 상태 관리를 위해 사용되었습니다.
- Hive(로컬스토리지): 일기와 설정 정보를 로컬에 저장하기 위해 사용되었습니다.
- widgetkit: 홈 화면 위젯과 데이터 교환을 위해 사용되었습니다.

## 주요 기능
- 일기 작성: 매일 간단한 일기를 작성하여 감정과 경험을 기록합니다.
- 감정 기록: 일기 작성 시 어플은 날씨로 감정을 분석하여 기록합니다.
- 다짐 작성: 매일 일기를 마치며 한 문장의 다짐을 작성하여 목표 달성에 도움을 줍니다.
- 글씨체, 강조 색상, 글씨 크기 변경: 사용자는 일기 작성 환경을 원하는 스타일로 커스터마이즈할 수 있습니다.
- 홈화면 위젯: 대표 다짐을 설정하고 홈화면 위젯을 사용자화하여 항상 다짐을 확인할 수 있습니다.

- MVVM 구조: 어플은 Flutter 프레임워크를 사용하고 MVVM 구조로 설계되었습니다.
- 데이터 저장: 일기와 설정 정보는 Hive 데이터베이스를 사용하여 안전하게 저장됩니다.

## 현재 진행 상태
- v1.0.0 Appstore 릴리즈 준비중입니다.
- 안드로이드 홈 위젯 개발 진행중입니다.
- 테스트하며 일부 버그를 제거하고 있습니다.

## 향후 계획
| 계획 | 설명 |
| --- | --- |
| 앱 스토어 출시 | "기분 일기 - 감정 기록 및 다짐 어플"을 App Store와 Play Store에 출시할 계획입니다. 사용자들이 편리하게 앱을 다운로드하여 이용할 수 있게 될 것입니다. |
| 감정 시각화 추가 | 사용자들이 기록한 감정을 시각적으로 분석하고 시각화할 수 있는 기능을 추가할 예정입니다. 그래프, 차트, 통계 등을 활용하여 사용자들이 자신의 감정 변화를 쉽게 이해하고 추적할 수 있도록 도움을 줄 것입니다. |
| 버그 개선 | 사용자들로부터 제보된 버그를 지속적으로 확인하고 개선할 예정입니다. 앱의 안정성을 향상시키고 사용자 경험을 최적화하기 위해 노력하겠습니다. |
| 검색 기능 추가 | 사용자들이 과거의 일기를 빠르게 찾고 검색할 수 있는 기능을 추가할 계획입니다. 키워드, 날짜, 감정 등을 기준으로 일기를 검색하고 접근할 수 있게 될 것입니다. |
| 사용자 인터페이스 개선 | 사용자들의 피드백과 요구에 근거하여 사용자 인터페이스를 개선할 계획입니다. 더 직관적이고 사용하기 편리한 디자인을 구현하고, 사용자들의 요구를 반영하여 UX를 최적화할 것입니다. |
| 다국어 지원 | 앱을 전 세계 사용자들에게 더욱 널리 제공하기 위해 다국어 지원을 추가할 예정입니다. 다양한 언어로 앱을 이용할 수 있게 함으로써 사용자들의 편의성을 높일 수 있습니다. |

## 설치 및 실행 방법
이 저장소를 클론하거나 압축 파일을 다운로드합니다.
만약, Flutter SDK가 설치되어 있지 않다면 Flutter 설치 가이드를 따라 설치합니다.
프로젝트 폴더로 이동하여 종속성을 설치합니다: flutter pub get.
Flutter를 사용하여 앱을 실행합니다: flutter run.
