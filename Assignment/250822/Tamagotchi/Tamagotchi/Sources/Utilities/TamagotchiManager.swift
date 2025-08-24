//
//  TamagotchiManager.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/24/25.
//

import Foundation

final class TamagotchiManager {
    
    static let shared = TamagotchiManager()
    private init() {}
    
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
    
    private let dataManager = DataManager.shared
    
    var rice: Int {
        get { dataManager.loadRice() }
        set { dataManager.saveRice(newValue) }
    }
    
    var water: Int {
        get { dataManager.loadWater() }
        set { dataManager.saveWater(newValue) }
    }
    
    var level: Int {
        get {
            let level = dataManager.loadLevel()
            return level == 0 ? 1 : level
        }
        set { dataManager.saveLevel(newValue) }
    }
    
    var nickName: String {
        get {
            return dataManager.loadUserNickname() ?? "대장"
        }
        set { dataManager.saveUserNickname(newValue) }
    }
    
    var imageText: String {
        guard let selectedType = dataManager.loadSelectedTamagotchiType() else {
            return "noImage"
        }
        
        var currentLevel = level
        if currentLevel == maxLevel {
            currentLevel = 9
        }
        
        return "\(selectedType.imagePrefix)-\(currentLevel)"
    }
    
    var isMaxLevel: Bool {
        return level >= maxLevel
    }
    
    // MARK: - Public Methods
    func eatRice(_ amount: Int) {
        rice += amount
        levelUp()
    }
    
    func drinkWater(_ amount: Int) {
        water += amount
        levelUp()
    }
    
    func randomMessage(for nickName: String) -> String {
        return String(format: messages.randomElement()!, nickName)
    }
    
    func getCurrentStats() -> TamagotchiStats {
        return TamagotchiStats(
            level: level,
            mealCount: rice,
            waterCount: water
        )
    }
    
    func resetTamagotchi() {
        level = 1
        rice = 0
        water = 0
    }
    
    // MARK: - Private Methods
    private func levelUp() {
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
