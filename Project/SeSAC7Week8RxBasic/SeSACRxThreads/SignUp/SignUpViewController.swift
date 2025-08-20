//
//  SignUpViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class SignUpViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let validationButton = UIButton()
    let nextButton = PointButton(title: "다음")
    
    // 중복확인 이 글자만 전달하면 할 일 끝
    let buttonTitle = Observable.just("중복확인")
    
    // 항상 붙여줘야 하는 건 알음
    // 근데 이게 뭘까?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        //configure()
        
        buttonTitle // Observable. 이벤트를 전달하는 역할
            .subscribe { value in
                print("onNext - \(value)")
                self.validationButton.setTitle(value, for: .normal)
            } onError: { error in
                print("onError - \(error)")
            } onCompleted: {
                print("onComplete")
            } onDisposed: {
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        buttonTitle.subscribe(with: self) { owner, value in
            print("onNext - \(value)")
            owner.validationButton.setTitle(value, for: .normal)
        }
        .disposed(by: disposeBag)


        
//        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
//        nextButton.rx.tap // Infinite Observable. 이벤트를 전달하는 역할.
//            .subscribe { [weak self] _ in
//                guard let self = self else { return }
//                print("button onNext")
//            } onDisposed: {                 // next, error, complete 이벤트 3개를 모두 처리할 수 있지만, 발생하지 않으므로 생략
//                print("button onDisposed")
//            }
//            .disposed(by: disposeBag)

        basicObservableTest()
        
//        nextButton.rx.tap
//            .withUnretained(self)
//            .bind { _ in // 애초에 next 이벤트 밖에 처리를 못하는 구조
//                print("button bind ontNext")
//                let vc = PasswordViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                print("button bind onNextttt")
                let vc = PasswordViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        print(#function)
//        navigationController?.pushViewController(PasswordViewController(), animated: true)
    }
    
    func basicObservableTest() {
        
        let list = ["고래밥", "칙촉", "카스타드", "갈배"]
        
        Observable.from(list)
            .subscribe { value in
                print("from \(value)")
            } onError: { error in
                print("from \(error)")
            } onCompleted: {
                print("from onComplete")
            } onDisposed: {
                print("from onDisposed")
            }
            .disposed(by: disposeBag)
        
        Observable.repeatElement(list)
            .take(20)
            .subscribe { value in
                print("repeatElement \(value)")
            } onError: { error in
                print("repeatElement \(error)")
            } onCompleted: {
                print("repeatElement onComplete")
            } onDisposed: {
                print("repeatElement onDisposed")
            }
            .disposed(by: disposeBag) // 리소스 정리 + 구독 취소

    }

    func configure() {
        validationButton.setTitle("중복확인", for: .normal)
        validationButton.setTitleColor(Color.black, for: .normal)
        validationButton.layer.borderWidth = 1
        validationButton.layer.borderColor = Color.black.cgColor
        validationButton.layer.cornerRadius = 10
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(validationButton)
        view.addSubview(nextButton)
        
        validationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
