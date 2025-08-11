//
//  MapViewModel.swift
//  task01
//
//  Created by 서준일 on 8/11/25.
//

import Foundation

class MapViewModel {
    
    var list = Observable<[Restaurant]>([])
    var currentFilter = Observable<FilterType>(.all)
    
    init() {
        fetchRestaurantList()
    }
    
    private func fetchRestaurantList() {
        // 실제로는 URLSession으로 통신하는 코드 쓰면 되고
        list.value = RestaurantList.restaurantArray
    }
    
    func applyFilter(_ value: FilterType) {
        currentFilter.value = value
        list.value.removeAll()
        
        switch value {
        case .korean:
            list.value = RestaurantList.restaurantArray.filter { $0.category == FilterType.korean.rawValue }
        case .western:
            list.value = RestaurantList.restaurantArray.filter { $0.category == FilterType.western.rawValue }
        case .japanese:
            list.value = RestaurantList.restaurantArray.filter { $0.category == FilterType.japanese.rawValue }
        case .cafe:
            list.value = RestaurantList.restaurantArray.filter { $0.category == FilterType.cafe.rawValue }
        case .chinese:
            list.value = RestaurantList.restaurantArray.filter { $0.category == FilterType.chinese.rawValue }
        case .lightWestern:
            list.value = RestaurantList.restaurantArray.filter { $0.category == FilterType.lightWestern.rawValue }
        case .snak:
            list.value = RestaurantList.restaurantArray.filter { $0.category == FilterType.snak.rawValue }
        case .all:
            fetchRestaurantList()
        }
    }
}
