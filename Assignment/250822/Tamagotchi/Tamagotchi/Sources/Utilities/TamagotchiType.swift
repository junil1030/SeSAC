//
//  TamagotchiType.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import Foundation

enum TamagotchiType {
    case cactus
    case cloud
    case star
    case none
    
    var selectImage: String {
        switch self {
        case .cactus:
            return "1-6"
        case .cloud:
            return "2-6"
        case .star:
            return "3-6"
        default:
            return "noImage"
        }
    }
    
    var selectName: String {
        switch self {
        case .cactus:
            return "따끔따끔 다마고치"
        case .cloud:
            return "방실방실 다마고치"
        case .star:
            return "반짝반짝 다마고치"
        default:
            return "준비중이에요"
        }
    }
}
