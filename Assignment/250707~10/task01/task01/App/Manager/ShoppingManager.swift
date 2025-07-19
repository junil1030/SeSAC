//
//  ShoppingManager.swift
//  task01
//
//  Created by 서준일 on 7/10/25.
//

import Foundation

final class ShoppingManager {
    private(set) var items: [[ShoppingItem]] = [
        [
            ShoppingItem(name: "1"),
            ShoppingItem(name: "2", isFavorite: true),
            ShoppingItem(name: "3"),
            ShoppingItem(name: "4", isFavorite: true),
            ShoppingItem(name: "5")
        ],
        [
            ShoppingItem(name: "6", isPurchased: true),
            ShoppingItem(name: "7", isFavorite: true, isPurchased: true),
            ShoppingItem(name: "8", isPurchased: true),
            ShoppingItem(name: "9", isPurchased: true),
            ShoppingItem(name: "10", isFavorite: true, isPurchased: true)
        ]
    ]
    
//    private(set) var purchasedItem: [ShoppingItem] = []
//    private(set) var unpurchasedItem: [ShoppingItem] = []
    
    func addItem(name: String) {
        let newItem = ShoppingItem(name: name)
        items[0].append(newItem)
    }
    
    func removeItem(at indexPath: IndexPath) {
        items[indexPath.section].remove(at: indexPath.row)
    }
    
    func updatePurchase(at indexPath: IndexPath) {
        var item = items[indexPath.section].remove(at: indexPath.row)
        item.isPurchased.toggle()
        let newSection = item.isPurchased ? 1 : 0
        items[newSection].append(item)
    }
    
    func updateFavorite(at indexPath: IndexPath) {
        items[indexPath.section][indexPath.row].isFavorite.toggle()
    }
}
