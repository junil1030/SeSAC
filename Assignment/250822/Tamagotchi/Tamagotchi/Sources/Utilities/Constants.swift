//
//  Constants.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import Foundation

enum UserDefaultsKey {
    static let userNickname = "UserNickname"
}

enum ColorName {
    static let backgroundColor = "backgroundColor"
    static let textColor = "textColor"
    static let buttonTappedColor = "buttonTappedColor"
}

enum Text {
    static let selectionViewTitle = "다마고치 선택하기"
}

enum Size {
    enum SelectionViewSize {
        static let minimumLineSpacing: CGFloat = 10
        static let minimumInteritemSpacing: CGFloat = 10
        
        enum Inset {
            static let top: CGFloat = 20
            static let left: CGFloat = 10
            static let bottom: CGFloat = 20
            static let right: CGFloat = 10
        }
    }
}
