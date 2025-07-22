//
//  JunilNavigationProtocol.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/22/25.
//

import Foundation

// Optional Requirements

@objc protocol JunilNavigationProtocol {
    
    // 왜 get만 설정했는데 set이 될까?
    // 프로퍼티 요구사항은 최소 요구 사항이기 때문에
    // get만 있으면 되고, set은 해도 되고 안해도 됨
    // 저장 프로퍼티로도 쓸 수 있고 연산 프로퍼티로도 쓸 수 있다.
    var myTitle: String { get }
    var myButton: String { get set }
    
    func configure()
    @objc optional func configureButton()
}
