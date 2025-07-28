//
//  AuthView.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/28/25.
//

import UIKit
import SnapKit

class AuthView: BaseView {
    
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
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(ageTextField)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        ageTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        picker.preferredDatePickerStyle = .wheels
        ageTextField.inputView = picker
    }
}
