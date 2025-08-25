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
        
        output.showInputValidationAlert
            .drive(with: self) { owner, validationType in
                owner.showInputValidationAlert(for: validationType)
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

extension ChangeNicknameViewController {
    enum InputValidationType {
        case tooShort
        case tooLong
        case startsWithSpace
        case containsInvalidCharacters
        
        var alertInfo: (title: String, message: String) {
            switch self {
            case .tooShort:
                return ("입력 제한", "이름은 2글자 이상이어야 해요!")
            case .tooLong:
                return ("입력 제한", "이름은 6글자 미만이어야 해요!")
            case .startsWithSpace:
                return ("잘못된 입력", "이름의 첫 글자는 공백일 수 없어요!")
            case .containsInvalidCharacters:
                return ("잘못된 입력", "이름에 사용할 수 없는 문자가 포함되어 있어요!")
            }
        }
    }
    
    func showInputValidationAlert(for type: InputValidationType) {
        let (title, message) = type.alertInfo
        showAlert(title: title, message: message)
    }
}
