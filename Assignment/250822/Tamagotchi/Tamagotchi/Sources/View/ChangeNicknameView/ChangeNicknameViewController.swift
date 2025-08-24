//
//  ChangeNicknameViewController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ChangeNicknameViewController: BaseViewController {
    
    private let changeView = ChangeNicknameView()
    private let viewModel = ChangeViewModel()
    private let saveButtonTappedRelay = PublishRelay<String?>()
    private let disposeBag = DisposeBag()
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(changeView)
        changeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        setupNavigationBarItems()
    }
    
    override func setupBind() {
        super.setupBind()
        
        let input = ChangeViewModel.Input(saveButtonTapped: saveButtonTappedRelay.asObservable())
        
        let output = viewModel.transfer(input: input)
        
        output.title
            .drive(with: self) { owner, title in
                owner.navigationItem.title = title
            }
            .disposed(by: disposeBag)
        
        output.changeComplete
            .drive(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.changeFail
            .drive(with: self) { owner, _ in
                owner.fail()
            }
            .disposed(by: disposeBag)
    }
    
    private func fail() {
        print("실패")
    }
    
    private func setupNavigationBarItems() {
        let saveButton = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        
        saveButton.tintColor = UIColor(named: ColorName.textColor)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func saveButtonTapped() {
        saveButtonTappedRelay.accept(changeView.getText())
    }
}
