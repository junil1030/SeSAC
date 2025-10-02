import Foundation

/// 영화 정보를 나타내는 모델
/// 
/// TMDB API에서 받아온 영화 데이터를 저장하고 관리합니다.
/// 
/// - Note: 모든 프로퍼티는 옵셔널이 아닌 값으로 보장됩니다.
/// - SeeAlso: `MovieRepository`에서 데이터를 가져옵니다.
final class MovieModel: Codable {
    /// 영화 ID
    let id: Int
    
    /// 영화 제목
    let title: String
    
    /// 영화 제목 (원문)
    let originalTitle: String
    
    /// 개봉일
    let releaseDate: String
    
    /// 포스터 이미지 경로
    let posterPath: String?
    
    /// 배경 이미지 경로
    let backdropPath: String?
    
    /// 영화 개요
    let overview: String
    
    /// 평점
    let voteAverage: Double
    
    /// 평점 투표 수
    let voteCount: Int
    
    /// 인기도
    let popularity: Double
    
    /// 성인 등급 여부
    let adult: Bool
    
    /// 장르 ID 목록
    let genreIds: [Int]
    
    /// 원어
    let originalLanguage: String
    
    /// 비디오 여부
    let video: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case adult
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case video
    }
    
    /// 포스터 이미지 전체 URL을 반환합니다.
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    /// 배경 이미지 전체 URL을 반환합니다.
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")
    }
    
    /// 포맷된 개봉일을 반환합니다. (yy.MM.dd 형식)
    var formattedReleaseDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: releaseDate) else {
            return releaseDate
        }
        
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
}

/// 영화 목록 응답 모델
final class MovieResponseModel: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

/// 영화 카테고리 열거형
enum MovieCategory: String, CaseIterable {
    case nowPlaying = "now_playing"
    case popular = "popular"
    case topRated = "top_rated"
    case upcoming = "upcoming"
    
    /// 카테고리별 한국어 제목
    var koreanTitle: String {
        switch self {
        case .nowPlaying:
            return "현재 상영중"
        case .popular:
            return "인기 영화"
        case .topRated:
            return "높은 평점"
        case .upcoming:
            return "개봉 예정"
        }
    }
}
