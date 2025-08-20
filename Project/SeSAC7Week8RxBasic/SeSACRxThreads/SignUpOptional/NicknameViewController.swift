//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    private let disposeBag = DisposeBag()
    
    private let placeholder = Observable.just("닉네임 입력")
    private let buttonTitle = Observable.just("닉네임 추천")
    private let text = BehaviorSubject(value: "고래밥")
    //Observable.just("고래밥")
    // 왜 subject로 써야하는지... 왜 =이 아니라 onNext로 데이터를 보내는지
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()

    }
    
    private func bind() {
        placeholder
            .bind(to: nicknameTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        buttonTitle
            .bind(to: nextButton.rx.title())
            .disposed(by: disposeBag)
        
        text
            .bind(to: nicknameTextField.rx.text)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                let list = ["칙촉", "갈배", "몽쉘"]
                let random = list.randomElement()!
                
                owner.text.onNext(random)
                
                owner.nicknameTextField.text = random
            }
            .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(BirthdayViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
         
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
