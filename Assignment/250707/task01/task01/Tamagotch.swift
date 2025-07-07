//
//  Tamagotch.swift
//  task01
//
//  Created by 서준일 on 7/7/25.
//

import Foundation

struct Tamagotch {
    private var level: Int = 1
    private var rice: Int = 0
    private var water: Int = 0
    
    mutating func eatRice(_ num: Int) {
        rice += num
        levelUP()
    }
    
    mutating func drinkWater(_ num: Int) {
        water += num
        levelUP()
    }
    
    private mutating func levelUP() {
        if rice >= 100, water >= 50 {
            let upNumber = min(rice / 100, water / 50)
            level += upNumber
            
            rice -= upNumber * 100
            water -= upNumber * 50
        }
    }
    
    func getLevel() -> Int {
        return level
    }
    
    func getRice() -> Int {
        return rice
    }
    
    func getWater() -> Int {
        return water
    }
}
