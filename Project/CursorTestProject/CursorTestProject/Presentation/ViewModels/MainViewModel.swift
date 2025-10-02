import Foundation
import RxSwift
import RxCocoa

/// 메인 화면의 ViewModel
final class MainViewModel {
    // MARK: - Properties
    let input: Input
    let output: Output
    
    private let networkService = SimpleNetworkService.shared
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    init() {
        self.input = Input()
        self.output = Output()
        
        bindInput()
    }
    
    // MARK: - Private Methods
    private func bindInput() {
        input.viewDidLoad
            .flatMapLatest { [weak self] _ -> Observable<[MovieSection]> in
                guard let self = self else { return .empty() }
                return self.fetchAllMovies()
            }
            .subscribe(onNext: { [weak self] sections in
                self?.output.movieSections.onNext(sections)
            }, onError: { [weak self] error in
                if let networkError = error as? NetworkError {
                    self?.output.errorMessage.onNext(networkError.localizedDescription)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchAllMovies() -> Observable<[MovieSection]> {
        let categories: [MovieCategory] = [.nowPlaying, .popular, .topRated, .upcoming]
        
        let observables = categories.map { category in
            networkService.fetchMovies(category: category)
                .map { movies in
                    MovieSection(category: category, movies: movies)
                }
        }
        
        return Observable.combineLatest(observables)
            .do(onSubscribe: { [weak self] in
                self?.output.isLoading.onNext(true)
            }, onDispose: { [weak self] in
                self?.output.isLoading.onNext(false)
            })
    }
}

// MARK: - Input
extension MainViewModel {
    struct Input {
        let viewDidLoad = PublishSubject<Void>()
    }
}

// MARK: - Output
extension MainViewModel {
    struct Output {
        let isLoading = BehaviorSubject<Bool>(value: false)
        let errorMessage = PublishSubject<String>()
        let movieSections = BehaviorSubject<[MovieSection]>(value: [])
    }
}

// MARK: - MovieSection
struct MovieSection {
    let category: MovieCategory
    let movies: [MovieModel]
}
