import Foundation
import RxSwift
import RxCocoa

/// 영화 상세 화면의 ViewModel
final class MovieDetailViewModel {
    // MARK: - Properties
    let input: Input
    let output: Output
    
    private let movie: MovieModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    init(movie: MovieModel) {
        self.movie = movie
        self.input = Input()
        self.output = Output()
        
        bindInput()
        setupInitialData()
    }
    
    // MARK: - Private Methods
    private func bindInput() {
        input.viewDidLoad
            .subscribe(onNext: { [weak self] in
                self?.handleViewDidLoad()
            })
            .disposed(by: disposeBag)
        
        input.backButtonTapped
            .subscribe(onNext: { [weak self] in
                self?.handleBackButtonTapped()
            })
            .disposed(by: disposeBag)
        
        input.playButtonTapped
            .subscribe(onNext: { [weak self] in
                self?.handlePlayButtonTapped()
            })
            .disposed(by: disposeBag)
        
        input.favoriteButtonTapped
            .subscribe(onNext: { [weak self] in
                self?.handleFavoriteButtonTapped()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupInitialData() {
        output.movie.onNext(movie)
        output.isFavorite.onNext(false) // 실제로는 로컬 저장소에서 확인
    }
    
    private func handleViewDidLoad() {
        // 추가 데이터 로딩이 필요한 경우 여기서 처리
    }
    
    private func handleBackButtonTapped() {
        output.navigationEvent.onNext(.back)
    }
    
    private func handlePlayButtonTapped() {
        // 플레이 기능 구현 (추후)
        output.showAlert.onNext("플레이 기능이 곧 추가됩니다.")
    }
    
    private func handleFavoriteButtonTapped() {
        let currentFavorite = try? output.isFavorite.value()
        let newFavorite = !(currentFavorite ?? false)
        output.isFavorite.onNext(newFavorite)
        
        let message = newFavorite ? "즐겨찾기에 추가되었습니다." : "즐겨찾기에서 제거되었습니다."
        output.showAlert.onNext(message)
    }
}

// MARK: - Input
extension MovieDetailViewModel {
    struct Input {
        let viewDidLoad = PublishSubject<Void>()
        let backButtonTapped = PublishSubject<Void>()
        let playButtonTapped = PublishSubject<Void>()
        let favoriteButtonTapped = PublishSubject<Void>()
    }
}

// MARK: - Output
extension MovieDetailViewModel {
    struct Output {
        let movie = BehaviorSubject<MovieModel?>(value: nil)
        let isFavorite = BehaviorSubject<Bool>(value: false)
        let navigationEvent = PublishSubject<NavigationEvent>()
        let showAlert = PublishSubject<String>()
    }
}

// MARK: - NavigationEvent
enum NavigationEvent {
    case back
    case play
    case share
}
