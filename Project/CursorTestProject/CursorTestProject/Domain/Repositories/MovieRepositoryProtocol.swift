import Foundation

/// 영화 데이터 접근을 위한 Repository 프로토콜
protocol MovieRepositoryProtocol {
    func fetchNowPlayingMovies(page: Int, completion: @escaping (Result<[MovieModel], NetworkError>) -> Void)
    func fetchPopularMovies(page: Int, completion: @escaping (Result<[MovieModel], NetworkError>) -> Void)
    func fetchTopRatedMovies(page: Int, completion: @escaping (Result<[MovieModel], NetworkError>) -> Void)
    func fetchUpcomingMovies(page: Int, completion: @escaping (Result<[MovieModel], NetworkError>) -> Void)
}
