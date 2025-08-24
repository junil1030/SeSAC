//
//  SettingItem.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/24/25.
//

import UIKit

enum SettingItemType {
    case nickname
    case changeTamagotchi
    case resetData
    
    var title: String {
        switch self {
        case .nickname:
            return "내 이름 설정하기"
        case .changeTamagotchi:
            return "다마고치 변경하기"
        case .resetData:
            return "데이터 초기화"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .nickname:
            return UIImage(systemName: "pencil")
        case .changeTamagotchi:
            return UIImage(systemName: "moon")
        case .resetData:
            return UIImage(systemName: "arrow.clockwise")
        }
    }
    
    var accessoryText: String? {
        switch self {
        case .nickname:
            return TamagotchiManager.shared.nickName
        default:
            return nil
        }
    }
}

struct SettingItem {
    let type: SettingItemType
    let title: String
    let icon: UIImage?
    let accessoryText: String?
    
    init(type: SettingItemType) {
        self.type = type
        self.title = type.title
        self.icon = type.icon
        self.accessoryText = type.accessoryText
    }
}
