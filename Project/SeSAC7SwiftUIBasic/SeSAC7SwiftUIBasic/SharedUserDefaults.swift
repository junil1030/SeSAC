//
//  SharedUserDefaults.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/30/25.
//

import Foundation

extension UserDefaults {
    
    static var groupShared: UserDefaults {
        
        let appID = "group.sesac.junil.widget"
        return UserDefaults(suiteName: appID)!
    }
    
    
}
