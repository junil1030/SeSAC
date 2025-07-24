//
//  MovieViewModel.swift
//  task01
//
//  Created by 서준일 on 7/24/25.
//

import Combine
import Foundation
import Alamofire

class MovieViewModel {
    
    private(set) var movieData: [DailyBoxOfficeList] = []
    
    private var targetDate: String = ""
    
    init() {
        targetDate = getCurrentDate()
    }
    
    private func fetchData() {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=dce81509c236477e2f0dc92663417742&targetDt=\(targetDate)"
        AF.request(url).responseDecodable(of: BoxOffice.self) { response in
            switch response.result {
            case .success(let movie):
                self.movieData = movie.boxOfficeResult.dailyBoxOfficeList
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    private func getCurrentDate() -> String {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter.string(from: yesterday)
    }
}
