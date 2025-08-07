//
//  UIViewController+Extension.swift
//  SeSAC7Week6
//
//  Created by 서준일 on 8/7/25.
//

import UIKit

extension UIViewController {
    
    // 타입 파라미터 -> 타입 제약을 줘야 하는데, (클래스 제약)을 주면 좋을 것 같다..
    // 제네릭을 활용한 경우. 선언된 함수에서는 어떤 타입이 들어올 지 알 수 없고,
    // 직접 실행하거나 활용할 때 타입이 나중에 들어오게 됨.
    // 즉 타입을 유추 할 수가 없음.
    // 궁금한 점: 유추가 불가능하기때문에 컴파일 시점에서는 알 수가 없는 것인지? 그렇다면 런타임 시점에 사용해야 하는데 성능적 측면에서 부담이 없는지?
    
    // Generic ParameterPack
    func setCornerRadius<T: UIView>(a: T) {
        a.layer.cornerRadius = 10
        a.clipsToBounds = true
    }
    
    func total<T: Numeric>(a: T, b: T) -> T {
        return a + b
    }
    
//    func total(a: Int, b: Int) -> Int {
//        return a + b
//    }
//    
//    func total(a: Double, b: Double) -> Double {
//        return a + b
//    }
//    
//    func total(a: Float, b: Float) -> Float {
//        return a + b
//    }
}
