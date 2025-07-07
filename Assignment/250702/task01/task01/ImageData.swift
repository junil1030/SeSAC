//
//  ImageData.swift
//  task01
//
//  Created by 서준일 on 7/2/25.
//

import UIKit

struct ImageData {
    private let imageArray: [UIImage] = [
        UIImage(named: "7번방의선물")!,
        UIImage(named: "겨울왕국")!,
        UIImage(named: "광해")!,
        UIImage(named: "괴물")!,
        UIImage(named: "국제시장")!,
        UIImage(named: "극한직업")!,
        UIImage(named: "노량")!,
        UIImage(named: "더퍼스트슬램덩크")!,
        UIImage(named: "도둑들")!,
        UIImage(named: "명량")!,
        UIImage(named: "밀수")!,
        UIImage(named: "범죄도시3")!,
        UIImage(named: "베테랑")!,
        UIImage(named: "부산행")!,
        UIImage(named: "서울의봄")!,
        UIImage(named: "스즈메의문단속")!,
        UIImage(named: "신과함께인과연")!,
        UIImage(named: "신과함께죄와벌")!,
        UIImage(named: "아바타")!,
        UIImage(named: "아바타물의길")!,
        UIImage(named: "알라딘")!,
        UIImage(named: "암살")!,
        UIImage(named: "어벤져스엔드게임")!,
        UIImage(named: "오펜하이머")!,
        UIImage(named: "왕의남자")!,
        UIImage(named: "육사오")!,
        UIImage(named: "콘크리트유토피아")!,
        UIImage(named: "태극기휘날리며")!,
        UIImage(named: "택시운전사")!,
        UIImage(named: "해운대")!,
    ]

    func getimage() -> UIImage {
        return imageArray[Int.random(in: 0...imageArray.count)]
    }
}
