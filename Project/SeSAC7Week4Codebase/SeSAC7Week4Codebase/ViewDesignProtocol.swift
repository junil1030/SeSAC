//
//  ViewDesignProtocol.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/22/25.
//

import Foundation
// 1. 강제, Interface
// Protocol Requirements
// Method Requirements
// Property Requirements
// 명세만 할 뿐, 구현은 구현부에서 해야함.
// 근데 extension을 사용해서 구현하는 것도 가능함

// UIKit class에서만 프로토콜을 채택할 수 있도록 함
// Any vs AnyObject(클래스 기반)
// static Dispatch방식이 아니라 Dynamic Dispatch 방식으로 작동함

protocol ViewDesignProtocol: AnyObject {
    
    func configureHierarchy()
    func configureLayout()
    func configureView()
    
}
