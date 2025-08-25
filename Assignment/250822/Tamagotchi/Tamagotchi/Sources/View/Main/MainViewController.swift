//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    
    private let mainView = MainView()
    private let mainViewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    private let mealButtonTappedRelay = PublishRelay<String?>()
    private let dropButtonTappedRelay = PublishRelay<String?>()
    private let viewWillAppearRelay = PublishRelay<Bool>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearRelay.accept(animated)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        setupNavigationBarItems()
    }
    
    override func setupDelegate() {
        super.setupDelegate()
        
    }
    
    override func setupBind() {
        super.setupBind()
        
        let input = MainViewModel.Input(
            mealButtonTapped: mealButtonTappedRelay.asObservable(),
            dropButtonTapped: dropButtonTappedRelay.asObservable(),
            viewWillAppear: viewWillAppearRelay.asObservable()
        )
        
        let output = mainViewModel.transform(input: input)
        
        output.title
            .drive(with: self) { owner, text in
                owner.title = text
            }
            .disposed(by: disposeBag)
        
        output.updateUI
            .drive(with: self) { owner, uiModel in
                owner.updateView(with: uiModel)
            }
            .disposed(by: disposeBag)
        
        output.showInputValidationAlert
            .drive(with: self) { owner, validationType in
                owner.showInputValidationAlert(for: validationType)
            }
            .disposed(by: disposeBag)
        
        mainView.onMealButtonTapped = { [weak self] text in
            self?.mealButtonTappedRelay.accept(text)
        }
        
        mainView.onDropButtonTapped = { [weak self] text in
            self?.dropButtonTappedRelay.accept(text)
        }
    }
    
    private func updateView(with data: MainViewTamagotchiInfo) {
        mainView.configure(
            tamagotchi: data.tamagotchi,
            stats: data.stats,
            message: data.message,
            imageText: data.imageText
        )
    }
    
    private func setupNavigationBarItems() {
        let settingButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(settingButtonTapped)
        )
        
        settingButton.tintColor = UIColor(named: ColorName.textColor)
        navigationItem.rightBarButtonItem = settingButton
    }
    
    @objc private func settingButtonTapped() {
        let vc = SettingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController {
    enum InputValidationType {
        case mealOverLimit
        case waterOverLimit
        case invalidMealInput
        case invalidWaterInput
        
        var alertInfo: (title: String, message: String) {
            switch self {
            case .mealOverLimit:
                return ("입력 제한", "밥은 최대 99개까지만 줄 수 있어요!")
            case .waterOverLimit:
                return ("입력 제한", "물은 최대 49개까지만 줄 수 있어요!")
            case .invalidMealInput:
                return ("잘못된 입력", "밥의 개수는 숫자로만 입력해주세요!")
            case .invalidWaterInput:
                return ("잘못된 입력", "물의 개수는 숫자로만 입력해주세요!")
            }
        }
    }
    
    func showInputValidationAlert(for type: InputValidationType) {
        let (title, message) = type.alertInfo
        showAlert(title: title, message: message)
    }
}
