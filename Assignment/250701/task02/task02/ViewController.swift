//
//  ViewController.swift
//  task02
//
//  Created by 서준일 on 7/1/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var recommendTextField: UITextField!
    
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var recommendLabel: UILabel!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var informSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 5
        
        setupTextColor()
        setupType()
        setupAlignment()
        setupPlaceholderColor()
        
        setupSignUpButton()
        setupInformSwitch()
        
        setupLabels()
    }
    
    func setupTextColor() {
        emailTextField.textColor = .white
        passwordTextField.textColor = .white
        nickNameTextField.textColor = .white
        countryTextField.textColor = .white
        recommendTextField.textColor = .white
    }
    
    func setupType() {
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupAlignment() {
        emailTextField.textAlignment = .center
        passwordTextField.textAlignment = .center
        nickNameTextField.textAlignment = .center
        countryTextField.textAlignment = .center
        recommendTextField.textAlignment = .center
    }

    func setupPlaceholderColor() {
        emailTextField.attributedPlaceholder =  NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        passwordTextField.attributedPlaceholder =  NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        nickNameTextField.attributedPlaceholder =  NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        countryTextField.attributedPlaceholder =  NSAttributedString(string: "위치", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        recommendTextField.attributedPlaceholder =  NSAttributedString(string: "추천 코드 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
    
    func setupSignUpButton() {
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.backgroundColor = .white
    }
    
    func setupInformSwitch() {
        informSwitch.setOn(false, animated: true)
        informSwitch.onTintColor = .red
        informSwitch.thumbTintColor = .white
    }
    
    func setupLabels() {
        emailLabel.isHidden = true
        passwordLabel.isHidden = true
        nickNameLabel.isHidden = true
        countryLabel.isHidden = true
        recommendLabel.isHidden = true
    }
    
    @IBAction func emailTextFieldEditingDidEnd(_ sender: UITextField) {
        if !sender.text!.contains("@")
            || sender.text!.count >= 11{
            emailLabel.isHidden = false
            emailLabel.text = "@가 포함되어 있지 않거나 11자 이상의 전화번호 형식이 아닙니다."
            emailLabel.textColor = .white
            emailLabel.font = .systemFont(ofSize: 10)
        } else {
            emailLabel.isHidden = true
        }
    }
    
    @IBAction func passwordTextFieldEditingDidEnd(_ sender: UITextField) {
        if sender.text!.count < 5 {
            passwordLabel.isHidden = false
            passwordLabel.text = "5글자 이상 입력해주세요."
            passwordLabel.textColor = .white
            passwordLabel.font = .systemFont(ofSize: 10)
        } else {
            passwordLabel.isHidden = true
        }
    }
    
    @IBAction func nickNameTextFieldEditingDidEnd(_ sender: UITextField) {
        if sender.text!.count < 1 {
            nickNameLabel.isHidden = false
            nickNameLabel.text = "1글자 이상 입력해주세요."
            nickNameLabel.textColor = .white
            nickNameLabel.font = .systemFont(ofSize: 10)
        } else {
            nickNameLabel.isHidden = true
        }
    }
    
    @IBAction func countryTextFieldEditingDidEnd(_ sender: UITextField) {
        if sender.text!.count < 1 {
            countryLabel.isHidden = false
            countryLabel.text = "1글자 이상 입력해주세요."
            countryLabel.textColor = .white
            countryLabel.font = .systemFont(ofSize: 10)
        } else {
            countryLabel.isHidden = true
        }
    }
    
    @IBAction func recommendTextFieldEditingDidEnd(_ sender: UITextField) {
        if sender.text!.count < 1 {
            recommendLabel.isHidden = false
            recommendLabel.text = "1글자 이상 입력해주세요."
            recommendLabel.textColor = .white
            recommendLabel.font = .systemFont(ofSize: 10)
        } else {
            recommendLabel.isHidden = true
        }
    }
    
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        print(sender.placeholder! + "필드 키보드 내려감")
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        if emailTextField.text!.isEmpty
            && passwordTextField.text!.isEmpty
            && nickNameTextField.text!.isEmpty
            && countryTextField.text!.isEmpty
            && recommendTextField.text!.isEmpty {
            print("입력이 안된 곳이 존재합니다.")
        } else {
            print("""
            email 또는 전화번호: \(emailTextField.text!)
            비밀번호: \(passwordTextField.text!)
            닉네임: \(nickNameTextField.text!)
            위치: \(countryTextField.text!)
            추천 코드 입력: \(recommendTextField.text!)
            """)
        }
    }
}

