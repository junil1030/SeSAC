//
//  SearchViewController.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
//

import Foundation
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    private let searchView = SearchView()
    private let viewModel = SearchViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func setupHierachy() {
        super.setupHierachy()
        
        view.addSubview(searchView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        title = "검색하기 화면"
    }
    
    override func setupBind() {
        super.setupBind()
        
        let input = SearchViewModel.Input(
            searchBarText: searchView.searchBar.rx.text.orEmpty.asObservable(),
            searchButtonTapped: searchView.searchBar.rx.searchButtonClicked.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.searchResult
            .drive(with: self) { owner, response in
                switch response {
                case .success(let value):
                    owner.navigateToResult(result: value)
                case .failure(let error):
                    print(error.description)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func navigateToResult(result: ShoppingResponse) {
        // ResultViewModel에 넣고 push
    }
}
