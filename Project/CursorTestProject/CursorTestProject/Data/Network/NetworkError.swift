import Foundation

/// 네트워크 관련 에러를 정의하는 열거형
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case invalidResponse
    case httpError(Int)
    case networkError(Error)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .noData:
            return "데이터가 없습니다."
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .httpError(let statusCode):
            return "HTTP 오류: \(statusCode)"
        case .networkError(let error):
            return "네트워크 오류: \(error.localizedDescription)"
        case .decodingError(let error):
            return "디코딩 오류: \(error.localizedDescription)"
        }
    }
}
