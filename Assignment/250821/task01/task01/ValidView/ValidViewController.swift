//
//  ValidViewController.swift
//  task01
//
//  Created by 서준일 on 8/19/25.
//

import UIKit
import RxCocoa
import RxSwift

final class ValidViewController: UIViewController {
    
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let usernameValidationLabel = UILabel()
    private let passwordValidationLabel = UILabel()
    private let submitButton = UIButton()
    
    private let minimumUsernameTextlength = 5
    private let minimumPasswordTextlength = 5
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        setupBind()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.placeholder = "사용자명을 입력하세요"
        
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "비밀번호를 입력하세요"
        passwordTextField.isSecureTextEntry = true
        
        usernameValidationLabel.text = "사용자명은 최소 5글자 이상이어야 합니다"
        usernameValidationLabel.textColor = .systemRed
        usernameValidationLabel.font = UIFont.systemFont(ofSize: 14)
        usernameValidationLabel.numberOfLines = 0
        
        passwordValidationLabel.text = "비밀번호는 최소 8글자 이상이어야 합니다"
        passwordValidationLabel.textColor = .systemRed
        passwordValidationLabel.font = UIFont.systemFont(ofSize: 14)
        passwordValidationLabel.numberOfLines = 0
        
        submitButton.setTitle("확인", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 8
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(usernameValidationLabel)
        view.addSubview(passwordValidationLabel)
        view.addSubview(submitButton)
    }
    
    private func setupLayout() {
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        
        usernameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameValidationLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        
        passwordValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidationLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
    }
    
    private func setupBind() {
        let userValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= self.minimumUsernameTextlength }
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= self.minimumPasswordTextlength }
        
        let totalValid = Observable.combineLatest(userValid, passwordValid) { $0 && $1 }
        
        userValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        userValid
            .bind(to: usernameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        totalValid
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }

}
