//
//  SelectionViewController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SelectionViewController: BaseViewController {
    
    private let selectionView = SelectionView()
    private let viewModel = SelectionViewModel()
    private let disposeBag = DisposeBag()
    
    private let startButtonTappedSubject = PublishSubject<TamagotchiItem>()
    private let cancelButtonTappedSubject = PublishSubject<Void>()
    
    private var currentPopupViewController: PopupViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Text.selectionViewTitle
    }

    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(selectionView)
        selectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupDelegate() {
        super.setupDelegate()
        
        selectionView.collectionView.delegate = self
    }
    
    override func setupBind() {
        super.setupBind()
        
        let input = SelectionViewModel.Input(
            itemSelected: selectionView.collectionView.rx.itemSelected.asObservable(),
            startButtonTapped: startButtonTappedSubject.asObservable(),
            cancelButtonTapped: cancelButtonTappedSubject.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(selectionView.collectionView.rx.items(cellIdentifier: TamagotchiCell.identifier, cellType: TamagotchiCell.self)) { index, item, cell in
                cell.configure(item: item)
            }
            .disposed(by: disposeBag)
        
        output.showPopup
            .drive(with: self) { owner, item in
                owner.showPopup(with: item)
            }
            .disposed(by: disposeBag)
        
        output.dismissPopup
            .drive(with: self) { owner, _ in
                owner.dismissPopup()
            }
            .disposed(by: disposeBag)
        
        output.navigateToMain
            .drive(with: self) { owner, tamagotchiType in
                owner.navigateToMainViewController(with: tamagotchiType)
            }
            .disposed(by: disposeBag)

    }
    
    private func showPopup(with item: TamagotchiItem) {
        let popupViewController = PopupViewController(selectedItem: item)
        
        popupViewController.onStartTapped = { [weak self] in
            self?.startButtonTappedSubject.onNext(item)
        }
        
        popupViewController.onCancelTapped = { [weak self] in
            self?.cancelButtonTappedSubject.onNext(())
        }
        
        currentPopupViewController = popupViewController
        present(popupViewController, animated: true)
    }
    
    private func dismissPopup() {
        currentPopupViewController?.dismiss(animated: true) { [weak self] in
            self?.currentPopupViewController = nil
        }
    }
    
    private func navigateToMainViewController(with tamagotchiType: TamagotchiType) {
        let vc = MainViewController()
        let nav = UINavigationController(rootViewController: vc)
        changeRootViewController(to: nav)
    }
}

extension SelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = Size.SelectionViewSize.minimumInteritemSpacing
        let totalSpacing = spacing * 2
        let edge: CGFloat = Size.SelectionViewSize.Inset.left
        let totalEdge = edge * 2
        let width = round((collectionView.frame.width - totalSpacing - totalEdge - 5) / 3)
        let height = width * 1.3
        
        return CGSize(width: width, height: height)
    }
}
