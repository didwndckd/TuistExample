# Tuist Example

> Tuist를 사용한 모듈화 샘플

## 모듈화 할 구조

간단한 구조로 알아보겠음.

- 앱은 `Home`, `Search`, `Common` 모듈에 의존한다
-  `Home`, `Search`는 클린 아키텍쳐 구조로 레이어 별로 타겟을 나누어 이루어지며 `Common` 모듈에 의존한다.

### App

- Home
  - Presentation
  - Domain
  - Data
- Search
  - Presentation
  - Domain
  - Data
- Common