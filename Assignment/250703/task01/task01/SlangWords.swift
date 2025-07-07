//
//  SlangWordsModel.swift
//  task01
//
//  Created by 서준일 on 7/3/25.
//

struct SlangWords{
    private let slangWords: [String: String] = [
        "무지컬": "피지컬도 없고 뇌지컬도 없는 사람",
        "손절미": "손절하고 싶어지는 특징",
        "테무인간": "일은 열심히 하는데 퀄리티는 별로인 사람",
        "한풀루언서": "한숨을 너무 크게 쉬어서 주변에 영향을 주는 사람",
        "위쑤시개": "스트레스 받을 때 먹는 매운 음식들",
        "밥플릭스": "밥 먹으면서 보는 영상",
        "랜선생님": "비대면으로 만났지만 큰 가르침을 주는 사람",
        "수발새끼": "여행 갔는데 손 까딱 안하고 수발 들어줘야 하는 사람",
        "TMT": "Too Much Talker",
        "JMT": "존맛탱"
    ]
    
    private var allKeys: [String] {
        return Array(slangWords.keys)
    }
    
    func searchWord(_ keyword: String) -> String? {
        let upperCase = keyword.uppercased()
        return slangWords[upperCase]
    }
    
    func getRandomKeywords(count: Int = 4) -> [String] {
        var keywords: Set<String> = []
        let allKeys = allKeys
        
        while keywords.count < min(count, allKeys.count) {
            let randomIndex = Int.random(in: 0..<allKeys.count)
            keywords.insert(allKeys[randomIndex])
        }
        
        return Array(keywords)
    }
}
