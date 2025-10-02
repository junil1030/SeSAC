import Foundation

/// 영화 관련 비즈니스 로직을 담당하는 UseCase
final class MovieUseCase {
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
    }
    
    /// 현재 상영중인 영화 목록을 가져옵니다.
    func fetchNowPlayingMovies(completion: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        repository.fetchNowPlayingMovies(page: 1, completion: completion)
    }
    
    /// 인기 영화 목록을 가져옵니다.
    func fetchPopularMovies(completion: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        repository.fetchPopularMovies(page: 1, completion: completion)
    }
    
    /// 높은 평점 영화 목록을 가져옵니다.
    func fetchTopRatedMovies(completion: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        repository.fetchTopRatedMovies(page: 1, completion: completion)
    }
    
    /// 개봉 예정 영화 목록을 가져옵니다.
    func fetchUpcomingMovies(completion: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        repository.fetchUpcomingMovies(page: 1, completion: completion)
    }
}
