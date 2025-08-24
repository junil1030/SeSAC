//
//  DataManager.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/23/25.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    private let manager = UserDefaults.standard
    
    //MARK: - Nickname Management
    func saveUserNickname(_ nickname: String) {
        manager.set(nickname, forKey: UserDefaultsKey.userNickname)
    }
    
    func loadUserNickname() -> String? {
        return manager.string(forKey: UserDefaultsKey.userNickname)
    }
    
    func removeUserNickname() {
        manager.removeObject(forKey: UserDefaultsKey.userNickname)
    }
    
    //MARK: - TamagotchiType Management
    func saveSelectedTamagotchiType(_ type: TamagotchiType) {
        manager.set(type.rawValue, forKey: UserDefaultsKey.selectedTamagotchi)
    }
    
    func loadSelectedTamagotchiType() -> TamagotchiType? {
        guard let typeString = manager.string(forKey: UserDefaultsKey.selectedTamagotchi) else {
            return nil
        }
        return TamagotchiType(rawValue: typeString)
    }
    
    func removeSelectedTamagotchiType() {
        manager.removeObject(forKey: UserDefaultsKey.selectedTamagotchi)
    }
    
    // MARK: - Rice Management
    func saveRice(_ rice: Int) {
        manager.set(rice, forKey: UserDefaultsKey.tamagotchiRice)
    }
    
    func loadRice() -> Int {
        return manager.integer(forKey: UserDefaultsKey.tamagotchiRice)
    }
    
    func removeRice() {
        manager.removeObject(forKey: UserDefaultsKey.tamagotchiRice)
    }
    
    // MARK: - Water Management
    func saveWater(_ water: Int) {
        manager.set(water, forKey: UserDefaultsKey.tamagotchiWater)
    }
    
    func loadWater() -> Int {
        return manager.integer(forKey: UserDefaultsKey.tamagotchiWater)
    }
    
    func removeWater() {
        manager.removeObject(forKey: UserDefaultsKey.tamagotchiWater)
    }
    
    // MARK: - Level Management
    func saveLevel(_ level: Int) {
        manager.set(level, forKey: UserDefaultsKey.tamagotchiLevel)
    }
    
    func loadLevel() -> Int {
        return manager.integer(forKey: UserDefaultsKey.tamagotchiLevel)
    }
    
    func removeLevel() {
        manager.removeObject(forKey: UserDefaultsKey.tamagotchiLevel)
    }
    
    // MARK: - Reset All Stats
    func resetTamagotchiStats() {
        removeRice()
        removeWater()
        removeLevel()
    }
    
    func resetAllData() {
        removeUserNickname()
        removeSelectedTamagotchiType()
        resetTamagotchiStats()
    }
    
    var isSelected: Bool {
        return loadSelectedTamagotchiType() != nil
    }
}
