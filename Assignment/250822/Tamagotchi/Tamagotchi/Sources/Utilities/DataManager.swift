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
    
    func saveUserNickname(_ nickname: String) {
        manager.set(nickname, forKey: UserDefaultsKey.userNickname)
    }
    
    func loadUserNickname() -> String? {
        return manager.string(forKey: UserDefaultsKey.userNickname)
    }
    
    func removeUserNickname() {
        manager.removeObject(forKey: UserDefaultsKey.userNickname)
    }
    
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
    
    func resetAllData() {
        removeUserNickname()
        removeSelectedTamagotchiType()
    }
    
    var isSelected: Bool {
        return loadSelectedTamagotchiType() != nil
    }
}
