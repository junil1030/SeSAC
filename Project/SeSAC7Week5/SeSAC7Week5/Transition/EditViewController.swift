//
//  EditViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 8/1/25.
//

import UIKit
import SnapKit

class EditViewController: UIViewController {
    
    var jun: DataPassprotocol?
    
    var space: ((String) -> Void)?
     
    private let textField1 = UITextField()
    private let textField2 = UITextField()
    private let textField3 = UITextField()
     
    private let button1 = UIButton()
    private let button2 = UIButton()
    private let button3 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(rightButtonTapped))
        
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
         
        setupTextField(textField1, placeholder: "Delegate 데이터")
        setupTextField(textField2, placeholder: "Closure 데이터")
        setupTextField(textField3, placeholder: "Notification 데이터")
         
        
        button1.configuration = UIButton.Configuration.myStyle(title: "Delegate")
        button2.configuration = UIButton.Configuration.myStyle(title: "Closure")
        button3.configuration = UIButton.Configuration.myStyle(title: "Notification")
//        setupButton(button1, title: "Delegate", color: .systemBlue)
//        setupButton(button2, title: "Closure", color: .systemGreen)
//        setupButton(button3, title: "Notification", color: .systemOrange)
         
        view.addSubview(textField1)
        view.addSubview(textField2)
        view.addSubview(textField3)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func setupButton(_ button: UIButton, title: String, color: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    private func setupConstraints() {
        // 첫 번째 텍스트필드
        textField1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 첫 번째 버튼
        button1.snp.makeConstraints { make in
            make.top.equalTo(textField1.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 두 번째 텍스트필드
        textField2.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 두 번째 버튼
        button2.snp.makeConstraints { make in
            make.top.equalTo(textField2.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 세 번째 텍스트필드
        textField3.snp.makeConstraints { make in
            make.top.equalTo(button2.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 세 번째 버튼
        button3.snp.makeConstraints { make in
            make.top.equalTo(textField3.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
    }
    
    @objc private func button1Tapped() {
        print("Delegate 버튼 눌림")
        
        let random = Int.random(in: 1...100)
        jun?.getRandomNumber(a: random)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func button2Tapped() {
        print("Closure 버튼 눌림")
        space?(textField2.text!)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func button3Tapped() {
        print("Notification 버튼 눌림")
        
        NotificationCenter.default.post(name: NSNotification.Name("TextEdited")
                                        , object: nil
                                        , userInfo: [
                                            "nickname": "Jun",
                                            "text": "\(textField3.text!)"
                                        ])
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func rightButtonTapped() {
        let vc = NextViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
