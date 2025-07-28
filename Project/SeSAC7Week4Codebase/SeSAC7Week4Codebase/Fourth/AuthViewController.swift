//
//  AuthViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/23/25.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    // 인스턴스 프로퍼티와 인스턴스 메서드는 인스턴스가 만들어진 시점 이후에만 사용이 가능함
    // 근데 지금 아래와 같은 코드는 인스턴스가 만들어지지도 않았는데 접근하려고 하니까 말이 안된다고 하는 거임
    // self가 아직 다 만들어지지 않았는데
    
    let mainView = AuthView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewdidload 시작")
        
        mainView.passwordTextField.delegate = self

        mainView.picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        print("viewdidload 끝")
    }
    
    @objc func datePickerValueChanged() {
        print(#function)
        mainView.ageTextField.text = "\(mainView.picker.date)"
        
    }
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        print(#function)
        return true
    }
    
    
}
