//
//  Constant.swift
//  SeSAC7Week5
//
//  Created by 서준일 on 8/5/25.
//

import UIKit

enum MyFont: String, CaseIterable {
    case thin = "가는체"
    case regular = "중간체"
    case bold = "볼드체"
    
    static let thin20 = UIFont(name: "S-CoreDream-1Thin", size: 20)
    static let medium20 = UIFont(name: "S-CoreDream-5Medium", size: 20)
    static let bold20 = UIFont(name: "S-CoreDream-9Black", size: 20)
}

struct MyFonts {
    private init() {}
    
    static let list = ["가는체", "중간체", "볼드체"]
    
    static let thin20 = UIFont(name: "S-CoreDream-1Thin", size: 20)
    static let medium20 = UIFont(name: "S-CoreDream-5Medium", size: 20)
    static let bold20 = UIFont(name: "S-CoreDream-9Black", size: 20)
}
