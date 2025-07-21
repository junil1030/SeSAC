//
//  ViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/21/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 오버로딩된 함수가 존재하기 때문에 이런식으로 써야함...
        // 근데 복잡하니까 그냥 이름을 나누는게 좋은 것 같기는 하다 ㅇㅇ
        goButton.addTarget(self, action: #selector(goButtonClicked as () -> Void), for: .touchUpInside)
        
        let anyany = otherFunction
        let name = anyany("as", "gg")
        
        print(anyany)
        print(name)
        
        var test = jack
        test = den
        
//        var test2 = finn
        // 위 코드는 왜 오류가 생길까...
        // 함수 타입이 모호해서
        let test2: (Int) -> String = finn(age:)
        // 이러면 되지롱
        
        print(test)
        print(test2)
    }

    @objc func goButtonClicked() {
        let vc = ResultViewController()
        
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

class User {
    
}

struct Mentor {
    let name: String
    let age: Int
    
    init(age: Int) {
        self.name = "고래밥"
        self.age = age
    }
    
    init(name: String) {
        self.name = name
        self.age = 26
    }
    
    init() {
        self.name = "고래밥"
        self.age = 26
    }
}
