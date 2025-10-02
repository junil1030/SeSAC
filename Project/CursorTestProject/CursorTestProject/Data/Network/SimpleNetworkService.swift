import Foundation
import RxSwift

/// 간단한 네트워크 서비스
final class SimpleNetworkService {
    static let shared = SimpleNetworkService()
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    private init() {}
    
    /// 영화 목록을 가져옵니다
    func fetchMovies(category: MovieCategory) -> Observable<[MovieModel]> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            let endpoint = self.createEndpoint(for: category)
            guard let urlRequest = endpoint.urlRequest else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            let task = self.session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    observer.onError(NetworkError.networkError(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    observer.onError(NetworkError.invalidResponse)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NetworkError.noData)
                    return
                }
                
                do {
                    let response = try self.decoder.decode(MovieResponseModel.self, from: data)
                    observer.onNext(response.results)
                    observer.onCompleted()
                } catch {
                    observer.onError(NetworkError.decodingError(error))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func createEndpoint(for category: MovieCategory) -> APIEndpoint {
        switch category {
        case .nowPlaying:
            return .nowPlaying()
        case .popular:
            return .popular()
        case .topRated:
            return .topRated()
        case .upcoming:
            return .upcoming()
        }
    }
}
