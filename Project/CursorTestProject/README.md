# TMDB 영화 앱

TMDB API를 활용한 영화 정보 앱입니다.

## 프로젝트 구조

```
CursorTestProject/
├── App/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── Info.plist
├── Presentation/
│   ├── ViewControllers/
│   │   ├── MainTabBarController.swift
│   │   ├── MainViewController.swift
│   │   ├── SearchViewController.swift
│   │   └── FavoriteViewController.swift
│   ├── Views/
│   │   └── MovieCollectionViewCell.swift
│   └── ViewModels/
│       └── MainViewModel.swift
├── Domain/
│   ├── Models/
│   │   └── MovieModel.swift
│   ├── UseCases/
│   │   └── MovieUseCase.swift
│   └── Repositories/
│       └── MovieRepositoryProtocol.swift
├── Data/
│   ├── Network/
│   │   ├── NetworkService.swift
│   │   ├── NetworkError.swift
│   │   └── APIEndpoint.swift
│   └── Repositories/
│       └── MovieRepository.swift
└── Resources/
    └── Assets.xcassets
```

## 기능

- **메인 화면**: 현재 상영중, 인기 영화, 높은 평점, 개봉 예정 영화를 섹션별로 표시
- **검색 화면**: 영화 검색 기능 (추후 구현)
- **즐겨찾기 화면**: 즐겨찾기한 영화 목록 (추후 구현)

## 기술 스택

- **UI**: UIKit, SnapKit
- **아키텍처**: MVVM 패턴 (Input-Output)
- **반응형 프로그래밍**: RxSwift, RxCocoa
- **네트워킹**: URLSession + RxSwift
- **이미지 캐싱**: Kingfisher
- **API**: TMDB API

## 설정 방법

### 1. 의존성 추가

Xcode에서 다음 패키지들을 추가해주세요:

1. **SnapKit** (버전 5.6.0)
   - URL: https://github.com/SnapKit/SnapKit.git

2. **RxSwift** (버전 6.6.0)
   - URL: https://github.com/ReactiveX/RxSwift.git

3. **Kingfisher** (버전 7.10.0)
   - URL: https://github.com/onevcat/Kingfisher.git

### 2. 프로젝트 설정

1. **Deployment Target**: iOS 15.0 이상
2. **Orientation**: Portrait만 지원
3. **Interface**: Storyboard 사용 안함

### 3. 빌드 및 실행

1. Xcode에서 프로젝트를 열기
2. 의존성 패키지 추가
3. 빌드 및 실행

## API 키

현재 TMDB API 키가 하드코딩되어 있습니다:
- API Key: `7a2cebd4a7ca505135292e820fca2df8`

보안을 위해 실제 배포 시에는 환경 변수나 설정 파일로 관리하는 것을 권장합니다.

## 주요 특징

- **MVVM 아키텍처**: View, ViewModel, Model의 명확한 분리
- **RxSwift**: 반응형 프로그래밍으로 데이터 바인딩
- **Input-Output 패턴**: ViewModel의 입출력을 구조체로 명확히 정의
- **메모리 관리**: weak 참조와 DisposeBag을 활용한 메모리 누수 방지
- **성능 최적화**: final 키워드와 적절한 접근 제어자 사용
- **에러 처리**: 명확한 에러 타입과 사용자 친화적 메시지

## 다음 단계

1. 검색 기능 구현
2. 즐겨찾기 기능 구현
3. 영화 상세 화면 구현
4. 이미지 캐싱 라이브러리 추가 (SDWebImage 등)
5. 무한 스크롤 구현
6. 오프라인 지원
