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
    let emailTextField: UITextField = {
        print("emailTextFiled 생성")
        let textField = PurpleTextField(placeholder: "이메일을 작성해주세요", keyboard: .emailAddress)
        return textField
    }()
    
    let passwordTextField = {
        print(#function)
        let textField = PurpleTextField(placeholder: "비밀번호를 작성해주세요", keyboard: .default)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var ageTextField = {
        let textField = PurpleTextField(placeholder: "나이를 선택해주세요", keyboard: .numberPad)
        textField.inputView = picker
        return textField
    }()
    
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewdidload 시작")
        configureHierarchy()
        configureLayout()
        configureView()
        
        passwordTextField.delegate = self
        
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        ageTextField.inputView = picker
        
        print("viewdidload 끝")
    }
    
    @objc func datePickerValueChanged() {
        print(#function)
        ageTextField.text = "\(picker.date)"
        
    }
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        print(#function)
        return true
    }
    
    
}

//MARK: - UI 속성 정의
extension AuthViewController: ViewDesignProtocol {
    
    func configureHierarchy() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(ageTextField)
    }
    
    func configureLayout() {
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        ageTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white

        
    }
}
