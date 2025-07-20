# PoketmonBook

## 소개
RxSwift 기반의 iOS 앱으로 포켓몬 API를 활용하여 포켓몬 목록과 상세 정보를 확인할 수 있는 프로젝트.

## 기술 스택 및 사용 기술
| 분야 | 내용 |
|------|------|
| UI 구성 | UIKit, SnapKit                                                                   |
| 네트워크 | URLSession + RxCocoa                                                             |
| 비동기 처리 | RxSwift + RxCocoa                                                              |
| 이미지 로딩 | Kingfisher                                                                     |
| 아키텍처 | MVVM 패턴                                                                         |
| 이벤트 전달 | RxRelay(PublishRelay), Observable 활용                                          |
| 스타일 확장 | UIColor 익스텐션을 통한 컬러 시스템 구성                                               |
|-----------------------|-------------------------------------------------------------------------------------------------------------|

---
```
PokédexApp/
├── Model/
│   └── Model.swift
├── Network/
│   └── NetworkManager.swift
├── View/
│   ├── CollectionCell.swift
│   └── DetailView.swift
├── ViewController/
│   ├── ViewController.swift
│   └── DetailViewController.swift
├── ViewModel/
│   ├── ViewModel.swift
│   └── DetailViewModel.swift
├── Extensions/
│   └── UIColor+Extension.swift
├── Resources/
│   └── Assets.xcassets
''
```

## 회고
- RxSwift를 실제 UI와 네트워크에 적용하며 Input/Output 패턴을 경험
- 데이터를 바인딩하는 흐름을 이해했고 명확한 데이터 흐름 관리가 가능해짐
- MVVM 패턴의 중요성을 체감
- Kingfisher를 사용해 이미지 캐싱을 직접 처리할 필요 없이 효율적으로 구성
- 네트워크 통신 처리를 Rx와 결합
