//
//  ProfileViewController.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/27/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ProfileViewController: UIViewController {
    
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    private let viewModel = ProfileViewModel()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        bind()
    }
    
    func bind() {
        let input = ProfileViewModel.Input(buttonTap: nextButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.detail
            .drive(with: self) { owner, value in
                print(">>>>", value, Thread.isMainThread)
                let viewModel = ProfileDetailViewModel(text: value)
                let vc = ProfileDetailViweController(viewModel: viewModel)
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.placeholder
            .drive(passwordTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        output.buttonTitle
            .drive(nextButton.rx.title())
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
         
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
