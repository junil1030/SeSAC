import Foundation

/// 영화 데이터 접근을 담당하는 Repository 구현체
final class MovieRepository: MovieRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchNowPlayingMovies(page: Int = 1, completion: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        networkService.request(
            endpoint: .nowPlaying(page: page),
            responseType: MovieResponseModel.self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPopularMovies(page: Int = 1, completion: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        networkService.request(
            endpoint: .popular(page: page),
            responseType: MovieResponseModel.self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopRatedMovies(page: Int = 1, completion: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        networkService.request(
            endpoint: .topRated(page: page),
            responseType: MovieResponseModel.self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUpcomingMovies(page: Int = 1, completion: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        networkService.request(
            endpoint: .upcoming(page: page),
            responseType: MovieResponseModel.self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
