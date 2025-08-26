//
//  LottoViewController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LottoViewController: BaseViewController {
    
    private let searchBar = UISearchBar()
    private let resultLabel = UILabel()
    
    private let searchButtonClickedRelay = PublishRelay<String>()
    
    private let viewModel = LottoViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func setupBind() {
        super.setupBind()
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                owner.searchButtonClickedRelay.accept(text)
            }
            .disposed(by: disposeBag)
        
        let input = LottoViewModel.Input(searchButtonClicked: searchButtonClickedRelay.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.lottoResult
            .drive(with: self) { owner, response in
                switch response {
                case .success(let value):
                    owner.searchBar.resignFirstResponder()
                    owner.searchBar.endEditing(true)
                    owner.configure(to: value)
                case .failure(let error):
                    owner.showAlert(title: "경고", message: error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)

    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(searchBar)
        view.addSubview(resultLabel)
        
        navigationItem.titleView = searchBar
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        view.backgroundColor = UIColor(named: ColorName.backgroundColor)
        
        resultLabel.textColor = .black
        resultLabel.font = .systemFont(ofSize: 14)
        
        resultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(to lotto: Lotto) {
        resultLabel.text = [lotto.drwtNo1, lotto.drwtNo2, lotto.drwtNo3,
                            lotto.drwtNo4, lotto.drwtNo5, lotto.drwtNo6, lotto.bnusNo]
                           .map { String($0) }
                           .joined(separator: ", ")
    }
}
