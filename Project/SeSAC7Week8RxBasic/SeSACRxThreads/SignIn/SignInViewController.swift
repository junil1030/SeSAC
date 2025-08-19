//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = UIButton()
    let photoImageView = UIImageView()
    
    let disposeBag = DisposeBag()
    
    let color = Observable.just(UIColor.yellow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 4자리 이상 이메일 작성 시, 로그인 버튼 회색 -> 검정색으로
//        emailTextField.rx.text
//            .bind(with: self) { owner, value in
//                guard let value = value else { return }
//                
//                if value.count >= 4 {
//                    owner.signInButton.backgroundColor = .black
//                } else {
//                    owner.signInButton.backgroundColor = .lightGray
//                }
//            }
//            .disposed(by: disposeBag)
        
//        emailTextField.rx.text.orEmpty
//            .bind(with: self) { owner, value in
//                if value.count >= 4 {
//                    owner.signInButton.backgroundColor = .black
//                } else {
//                    owner.signInButton.backgroundColor = .lightGray
//                }
//            }
//            .disposed(by: disposeBag)
        
//        emailTextField.rx.text.orEmpty
//            .map { $0.count >= 4 }
//            .bind(with: self) { owner, value in
//                owner.signInButton.backgroundColor = value ? .black : .lightGray
//            }
//            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .map { $0.count < 4 }
            .bind(to: signInButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        color
            .bind(to: view.rx.backgroundColor,
                   emailTextField.rx.textColor)
            .disposed(by: disposeBag)
        
        // 위 아래는 같은 코드임
        // 아래는 근데 rx적인 코드는 아니기 때문에 위 처럼 쓰려고 해보자
        
//        color.bind(with: self) { owner, color in
//            owner.view.backgroundColor = color
//            owner.emailTextField.textColor = color
//        }
//        .disposed(by: disposeBag)

//        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    @objc func signInButtonClicked() {
        PhotoManager.shared.getRandomPhoto(api: .random) { photo in
            print("random", photo)
            self.photoImageView.kf.setImage(with: URL(string: photo.urls.regular))
        }
    }
    
    @objc func signUpButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    
    func configure() {
        signUpButton.setTitle("회원이 아니십니까?", for: .normal)
        signUpButton.setTitleColor(Color.black, for: .normal)
        photoImageView.backgroundColor = .blue
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(photoImageView)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
        }
    }
    

}
