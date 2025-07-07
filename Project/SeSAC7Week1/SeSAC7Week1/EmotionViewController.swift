//
//  EmotionViewController.swift
//  SeSAC7Week1
//
//  Created by 서준일 on 7/2/25.
//

import UIKit

class EmotionViewController: UIViewController {
    
    @IBOutlet var emotionLabel: [UILabel]!
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var thirdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in emotionLabel {
            item.textColor = .blue
        }
        
        // () 함수호출연산자
        // Parameter: 아무리 많이 함수를 호출하더라도 달라지지 않는 주머니 이름 (매개변수)
        // Arguments: 매번 다른 값들이 들어가는 부분 (전달인자)
        designTextField(firstTextField, ph: "닉네임을 입력해주세요")
        designTextField(secondTextField, ph: "아이디를 입력해주세요")
        designTextField(thirdTextField, ph: "비밀번호를 입력해주세요", isSecure: true)
    }
    
    // 매개변수(Parameter)
    // 내부 매개변수 textField: Parameter name
    // 외부 매개변수 tf: Arguments label
    // 와일드카드 식별자 (_)를 통해 외부 매개변수를 생략할 수 있음
    // 매개변수 기본값
    func designTextField(_ textField: UITextField, ph placeholder: String, isSecure: Bool = false) {
        textField.placeholder = placeholder
        textField.textColor = .brown
        textField.font = .systemFont(ofSize: 20)
        textField.borderStyle = .bezel
        if isSecure { textField.isSecureTextEntry = true }
    }

    @IBAction func didEndOnExit(_ sender: UITextField) {
        
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        print(#function)
        view.endEditing(true)
    }
}
