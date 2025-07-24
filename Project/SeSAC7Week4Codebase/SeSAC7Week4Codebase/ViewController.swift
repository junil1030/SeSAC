//
//  ViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/21/25.
//

import UIKit

struct BMI {
    static var name = "고래밥"     // 타입 프로퍼티
    let height: Double           // 인스턴스 프로퍼티
    let weight: Double
    
    var result: String {         // 저장 프로퍼티
        get {
            let value = weight / (height * height)
            
            if value < 18.5 {
                return "저체중입니다"
            } else {
                return "정상 이상입니다."
            }
        }
        
        set {
            BMI.name = newValue
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var goButton: UIButton!
    
    // Swift 5.7+ if let shorthand
    var nickname: String?
    var age: Int?
    
    
    var ud = UserDefaultsHelper()
    
    var bmi = BMI(height: 1.8, weight: 80)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(ud.name)
//        print(ud.age)
//        
//        ud.age = 345
//        ud.name = "Junil"
//        
//        print(ud.name)
//        print(ud.age)
//        
//        print(BMI.name)
//        print(bmi.height, bmi.weight)
//        
//        print(bmi.result)
//        
//        bmi.result = "Junil"
//        
//        print(bmi.result)
        
        
        
//        if let nickname, let age {
//            print(nickname, age)
//        }
        
        // 오버로딩된 함수가 존재하기 때문에 이런식으로 써야함...
        // 근데 복잡하니까 그냥 이름을 나누는게 좋은 것 같기는 하다 ㅇㅇ
        goButton.addTarget(self, action: #selector(goButtonClicked as () -> Void), for: .touchUpInside)
        
//        let anyany = otherFunction
//        let name = anyany("as", "gg")
//        
//        print(anyany)
//        print(name)
//        
//        let some = ###"""
//                Raw string 문자열에 포함된 """#
//                #의 갯수가 다르기 때문에 하나의 문자열로 인식
//            """###
//        print(some)
//        
//        var test = jack
//        test = den
        
//        var test2 = finn
        // 위 코드는 왜 오류가 생길까...
        // 함수 타입이 모호해서
//        let test2: (Int) -> String = finn(age:)
//        // 이러면 되지롱
//        
//        print(test)
//        print(test2)
    }
    
    @objc func goButtonClicked() {
        
//        print(BMI.name)
//        print(bmi.height, bmi.weight)
//        
//        let result = bmi.weight / (bmi.height * bmi.height)
//        
//        if result < 18.5 {
//            print("저체중")
//        } else {
//            print("정상이상")
//        }
        
        
        
//        guard let height = heightTextField.text, height.count > 2 else {
//            print("키, 무게 텍스트 필드가 2글자 미만입니다.")
//            return
//        }
//        
//        if let height = heightTextField.text, height.count > 2 {
//            print(height)
//        } else {
//            print("키 텍스트 필드가 2글자 미만입니다.")
//        }
//        
//        if let weight = weightTextField.text, weight.count > 2 {
//            print(weight)
//        } else {
//            print("무게 텍스트 필드가 2글자 미만입니다.")
//        }
        
        let vc = MarketViewController()
        
        present(vc, animated: true)
    }
    
    func goButtonClicked(a: Int) {
        
    }
    
    func otherFunction(a: String, b: String) -> String {
        return "wowowow" + a + b
    }
    
    func jack() -> String {
        return "I'm Jack"
    }
    
    func den() -> String {
        return "I'm Den"
    }
    
    func finn() -> String {
        return "I'm Finn"
    }
    
    func finn(age: Int) -> String {
        return "I'm Finn, \(age) years old"
    }
}
