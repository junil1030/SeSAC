//
//  Tamagotch.swift
//  task01
//
//  Created by 서준일 on 7/7/25.
//

import Foundation

class TamagotchManager {
    private let minLevel = 1
    private let maxLevel = 10
    
    private let messages = [
        "%@, 분발해야할듯?!",
        "초심 잃었는데요, %@님?",
        "졸리다구요? %@님 취업 안 할거에요?",
        "%@님... 딴짓할 시간에 코드 보는게 도움될 걸요..",
        "%@님 밥이랑 물은 주고 공부하러 가세요~!",
        "과제는 다 했어요? 안 했다구요? 미치셨습니까 휴먼?"
    ]
    
    private enum UserDefaultsKeys: String {
        case rice = "tamagotch_rice"
        case water = "tamagotch_water"
        case level = "tamagotch_level"
        case nickName = "tamagotch_nickName"
    }
    
    static let shared = TamagotchManager()
    private init() {}
    
    var rice: Int {
        get { UserDefaults.standard.integer(forKey: UserDefaultsKeys.rice.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.rice.rawValue) }
    }
    
    var water: Int {
        get { UserDefaults.standard.integer(forKey: UserDefaultsKeys.water.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.water.rawValue) }
    }
    
    var level: Int {
        get {
            let level = UserDefaults.standard.integer(forKey: UserDefaultsKeys.level.rawValue)
            return level == 0 ? 1 : level
        }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.level.rawValue) }
    }
    
    var nickName: String {
        get {
            let name = UserDefaults.standard.string(forKey: UserDefaultsKeys.nickName.rawValue)
            return name == nil ? "대장" : name!
        }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.nickName.rawValue)}
    }
    
    var imageText: String {
        var currentLevel = level
        if currentLevel == maxLevel {
            currentLevel = 9
        }
        return "2-\(currentLevel)"
    }
    
    var isMaxlevel: Bool {
        return level >= maxLevel
    }
    
    func eatRice(_ num: Int) {
        rice += num
        levelUP()
    }
    
    func drinkWater(_ num: Int) {
        water += num
        levelUP()
    }
    
    func randomMessage(for nickName: String) -> String {
        return String(format: messages.randomElement()!, nickName)
    }
    
    func resetTamagotch() {
        level = 1
        rice = 0
        water = 0
    }
    
    private func levelUP() {
        let calculatedLevel = calculateLevel()
        level = max(minLevel, min(calculatedLevel, maxLevel))
    }
    
    private func calculateLevel() -> Int {
        let riceScore = Double(rice) / 5.0
        let waterScore = Double(water) / 2.0
        let totalScore = riceScore + waterScore
        
        let calculatedLevel = Int(totalScore / 10.0)
        return max(1, calculatedLevel)
    }
}
