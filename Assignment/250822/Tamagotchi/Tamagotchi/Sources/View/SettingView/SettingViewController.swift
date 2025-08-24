//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
    
    private let settingView = SettingView()
    private let viewModel = SettingViewModel()
    
    private let disposeBag = DisposeBag()
    
    private let resetConfirmedRelay = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "설정"
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(settingView)
        settingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        let input = SettingViewModel.Input(
            itemSelected: settingView.tableView.rx.itemSelected.asObservable(),
            resetConfirmed: resetConfirmedRelay.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(settingView.tableView.rx.items(cellIdentifier: SettingTableViewCell.identifier, cellType: SettingTableViewCell.self)) { index, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        output.changeNickname
            .drive(with: self) { owner, _ in
                owner.pushChangeNicknameView()
            }
            .disposed(by: disposeBag)
        
        output.changeTamagotchi
            .drive(with: self) { owner, _ in
                owner.changeTamagotchi()
            }
            .disposed(by: disposeBag)
        
        output.resetData
            .drive(with: self) { owner, _ in
                owner.showResetAlert()
            }
            .disposed(by: disposeBag)
        
        output.resetConfirm
            .drive(with: self) { owner, _ in
                owner.changeTamagotchi()
            }
            .disposed(by: disposeBag)
    }
    
    private func pushChangeNicknameView() {
        self.navigationItem.backButtonTitle = "설정"
        let vc = ChangeNicknameViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func changeTamagotchi() {
        let vc = SelectionViewController()
        let nav = UINavigationController(rootViewController: vc)
        changeRootViewController(to: nav)
    }
    
    private func showResetAlert() {
        let alert = UIAlertController(
            title: "데이터 초기화",
            message: "정말로 모든 데이터를 초기화하시겠습니까?\n이 작업은 되돌릴 수 없습니다.",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "초기화", style: .destructive) { [weak self] _ in
            self?.resetConfirmedRelay.accept(())
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        present(alert, animated: true)
    }
}
