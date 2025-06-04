# PawPrints

## Tech Stacks

`Flutter`, `Dart`, `MVVM`

`Provider`, `Dio`, `GoRouter`

`flutter_svg`, `image_picker`, `figma`

## Architectures - MVVM

### Provider - State Management & DI (built-in standard)
![PROVIDER](https://github.com/user-attachments/assets/c5381208-5d44-4cb7-8442-b22bca665ab2)

### File Structure
```
lib/
├── main.dart
├── app/
├── config/
│   ├── constant/
│   ├── route/
│   └── theme/
├── core/
│   └── network/
├── data/
│   ├── models/
│   └── repositories/
├── notifications/
├── screens/
│   ├── auth/
│   ├── care/
│   ├── chat/
│   ├── community/
│   ├── home/
│   ├── memory/
│   ├── mission/
│   ├── my/
│   ├── notification/
│   ├── schedule/
│   ├── index.dart
│   └── root_screen.dart
├── utils/
│   ├── enums/
│   ├── functions/
│   └── permissions/
├── providers/
└── widgets/
```

## Permissions

`알림` `갤러리 / 카메라` ~`위치`~

## Packages

**`permission_handler`** **`image_picker`** **`flutter_svg`** **`dio`** **`go_router`** **`logger`** **`flutter_local_notifications`** **`connectivity_plus`** **`shared_preferences`** **`flutter_launcher_icons`** **`flutter_native_splash`** **`flutter_lints`** **`build_runner`** **`flutter_secure_storage`**

## Roles

정보영 : 데이터 연동, 모듈 설계, 배포

정태영 : UI, 커뮤니티, 챗봇

전태수 : UI, 홈, 추억

## Rules

### Pragma Mark

### **issue & pr template → 사용  X (주석으로 대체)**

**날짜**, 마커와 함께 내용을 포함

ex.  `// 04.29 - NOTE: MaterialApp`

| 마커 | 정의 |
| --- | --- |
| WIP | "작업 중" 또는 "진행 중”, 아직 완료되지 않았지만 현재 작업하고 있는 기능이나 코드 블록을 나타낼 때 사용 |
| TODO | "해야 할 일”, 당장은 아니지만 나중에 구현해야 할 기능, 추가해야 할 작업, 또는 수정해야 할 부분을 표시할 때 사용 |
| NOTE | "참고", "메모”, 코드의 특정 결정에 대한 이유나 작동 방식에 대한 추가적인 설명 |
| HACK | "임시방편", "꼼수”, 이상적인 해결책은 아니지만, 임시로 문제를 해결하거나 기능을 구현하기 위해 사용한 코드 조각을 표시 |
| FIXME | "수정 필요”, 코드에 문제가 있거나 버그가 있어서 반드시 수정해야 하는 부분을 표시할 때 사용 |
| XXX | "주의 필요", "문제 있음”, `FIXME`와 유사하게 코드의 특정 부분에 문제가 있거나 주의 깊게 봐야 할 부분이 있음을 **강조** |
| BUG | "버그”, 코드 내에 알려진 버그가 있는 위치를 명시적으로 표시할 때 사용 |
