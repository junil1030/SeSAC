import Foundation

/// 네트워크 통신을 담당하는 서비스 프로토콜
protocol NetworkServiceProtocol {
    func request<T: Codable>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

/// URLSession을 사용한 네트워크 서비스 구현체
final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    private var dataTasks: [URLSessionDataTask] = []
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    deinit {
        cancelAllRequests()
    }
    
    func request<T: Codable>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let urlRequest = endpoint.urlRequest else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.handleResponse(
                    data: data,
                    response: response,
                    error: error,
                    responseType: responseType,
                    completion: completion
                )
            }
        }
        
        dataTasks.append(task)
        task.resume()
    }
    
    private func handleResponse<T: Codable>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        if let error = error {
            completion(.failure(.networkError(error)))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(.invalidResponse))
            return
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            completion(.failure(.httpError(httpResponse.statusCode)))
            return
        }
        
        guard let data = data else {
            completion(.failure(.noData))
            return
        }
        
        do {
            let decodedData = try decoder.decode(responseType, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    private func cancelAllRequests() {
        dataTasks.forEach { $0.cancel() }
        dataTasks.removeAll()
    }
}
