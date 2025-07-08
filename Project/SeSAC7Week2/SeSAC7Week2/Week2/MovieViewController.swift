//
//  MovieViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/8/25.
//

import UIKit

struct Movie {
    let title: String
    let openDate: String
    let runtime: Int
    
}

class MovieViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var movieLabel: UILabel!
    
    let list: [Movie] = [
        Movie(title: "어벤져스", openDate: "2021", runtime: 143),
        Movie(title: "쥬라기월드", openDate: "2025", runtime: 120),
        Movie(title: "추격자", openDate: "2008", runtime: 123),
        Movie(title: "인터스텔라", openDate: "2014", runtime: 169)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieLabel.numberOfLines = 0

        let number = Int.random(in: 0...list.count - 1)
        movieLabel.text = "\(list[number])"
        
        // 1. 국가마다 시간이 다른 걸 맞춰주어야 함
        // 2. 사용자 입장에서 날짜를 표현하기
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd a HH:mm:ss EEEE"
        format.locale = Locale(identifier: "ko-KR")
        
        let result = format.string(from: Date())
        
        dateLabel.text = result
    }
    

}
