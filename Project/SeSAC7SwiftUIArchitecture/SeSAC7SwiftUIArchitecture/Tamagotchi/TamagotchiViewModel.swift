//
//  TamagotchiViewModel.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/3/25.
//

import Foundation

// @State: View Source Of Truth State > body
// @State == View
// ViewModel은 View가 아님 -> @State가 아니라 다른 키워드 필요
// 어떤 키워드인지 몰라도 rice가 달라지면 rice > ViewModel > view > body
// @Published: 프로퍼티 데이터가 변경될 때 뷰가 업데이트 되도록 도와주는 키워드


final class TamagotchiViewModel: ObservableObject {
    @Published var rice = 0
    @Published var water = 0
    @Published var riceField = ""
    @Published var waterField = ""
    
    func addRice() {
        if let count = Int(riceField ) {
            rice += count
        } else {
            rice += 1
        }
    }
    
    func addWater() {
        if let count = Int(waterField) {
            water += count
        } else {
          water += 1
        }

    }
}

@Observable
final class TamagotchiViewModelObservable {
    var rice = 0
    var water = 0
    var riceField = ""
    var waterField = ""
    
    func addRice() {
        if let count = Int(riceField ) {
            rice += count
        } else {
            rice += 1
        }
    }
    
    func addWater() {
        if let count = Int(waterField) {
            water += count
        } else {
          water += 1
        }

    }
}
