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
    
    var overView: String {
        switch self {
        case .cactus:
            return "저는 따끔따끔 다마고치입니다. 키는 2cm이고 몸무게는 150g이에요. 성격은 소심하지만 마음은 따뜻해요. 열심히 잘 먹고 잘 클 자신은 있답니다. 반가워요 주인님!!!"
        case .cloud:
            return "저는 방실방실 다마고치입니당 키는 100km이고 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!"
        case .star:
            return "저는 반짝반짝 다마고치에요 키는 5cm이고 몸무게는 0.5g이에요 성격은 밝고 반짝반짝 빛나는 게 특기랍니다 주인님과 함께 반짝반짝 성장할게요~!"
        default:
            return "저는 아직 태어나지 않은 다마고치에요"
        }
    }
}
