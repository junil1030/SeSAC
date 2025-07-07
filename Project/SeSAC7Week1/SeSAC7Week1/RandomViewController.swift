//
//  RandomViewController.swift
//  SeSAC7Week1
//
//  Created by 서준일 on 7/1/25.
//

import UIKit

class RandomViewController: UIViewController {
    
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var userTextField: UITextField!
    
    var nickName = "고래밥"
    
    // 사용자 눈에 보이기 직전에 실행되는 기능
    // 모서리 둥글기, 그림자 등 속성을 미리 설정할 때 사용
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        
        userTextField.placeholder = "입력해보세요"
        userTextField.keyboardType = .emailAddress
        userTextField.borderStyle = .bezel
        userTextField.isSecureTextEntry = false
        
        resultLabel.backgroundColor = .yellow
        resultLabel.textColor = .point
        resultLabel.text = "안녕하세요"
        resultLabel.numberOfLines = 2
        resultLabel.font = .systemFont(ofSize: 20)
        resultLabel.textAlignment = .center
        resultLabel.alpha = 0.8
        resultLabel.clipsToBounds = true
        resultLabel.layer.cornerRadius = 20
        resultLabel.layer.borderWidth = 3
        resultLabel.layer.borderColor = UIColor.red.cgColor
    }
    
    func designCheckButtonUI() {
        checkButton.setTitle("클릭하지마세요", for: .normal)
        checkButton.setTitleColor(.lightGray, for: .normal)
        checkButton.setTitle("누르지말라니까", for: .highlighted)
        checkButton.setTitleColor(.red, for: .highlighted)
        checkButton.backgroundColor = .cyan
        checkButton.layer.cornerRadius = 50
        checkButton.layer.borderWidth = 5
        checkButton.layer.borderColor = UIColor.brown.cgColor
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        print("버튼 클릭 됨")
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        
        resultLabel.text = "고래밥 \(numberFormatter.string(for: Int.random(in: 1...21314214))!)개"
        
        designCheckButtonUI()
    }
    
    @IBAction func userTextFieldEditingChanged(_ sender: UITextField) {
        print("이게뭐지")
        print(userTextField.text!.count)
    }
    
    @IBAction func userTextFieldDidEndOnExit(_ sender: UITextField) {
        print("너는뭔데")
    }
}

