import Foundation

/// TMDB API 엔드포인트를 정의하는 열거형
enum APIEndpoint {
    case nowPlaying(page: Int = 1)
    case popular(page: Int = 1)
    case topRated(page: Int = 1)
    case upcoming(page: Int = 1)
    
    private var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    private var apiKey: String {
        return "7a2cebd4a7ca505135292e820fca2df8"
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var urlRequest: URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL + path) else { return nil }
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "ko-KR")
        ]
        
        switch self {
        case .nowPlaying(let page), .popular(let page), .topRated(let page), .upcoming(let page):
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}

/// HTTP 메서드를 정의하는 열거형
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}
