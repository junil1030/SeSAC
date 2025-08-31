//
//  SearchViewController.swift
//  task01
//
//  Created by 서준일 on 7/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    let viewModel = SearchViewModel()
    
    private let searchbar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.showsCancelButton = false
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로핑, 태그 등", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return searchBar
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBind()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(searchbar)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        searchbar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = AppStrings.appTItle
    }
    
    private func setupBind() {
        let input = SearchViewModel.Input(
            searchBarText: searchbar.rx.text.orEmpty.asObservable(),
            searchButtonClicked: searchbar.rx.searchButtonClicked.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.showEmptyAlert
            .drive(with: self) { owner, message in
                owner.showAlert(type: .error, message: message)
            }
            .disposed(by: disposeBag)
        
        output.showNetworkErrorAlert
            .drive(with: self) { owner, message in
                owner.showAlert(type: .networkError, message: message)
            }
            .disposed(by: disposeBag)
        
        output.searchKeyword
            .drive(with: self) { owner, keyword in
                let vc = ResultViewController(searchKeyword: keyword)
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
