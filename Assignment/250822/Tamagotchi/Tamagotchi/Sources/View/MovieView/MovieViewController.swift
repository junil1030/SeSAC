//
//  MovieViewController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MovieViewController: BaseViewController {
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    private let searchButtonClickedRelay = PublishRelay<String>()
    
    private let viewModel = MovieViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func setupBind() {
        super.setupBind()
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                owner.searchButtonClickedRelay.accept(text)
            }
            .disposed(by: disposeBag)
        
        let input = MovieViewModel.Input(searchButtonClicked: searchButtonClickedRelay.asObservable())

        let output = viewModel.transform(input: input)
        
        output.movieList
            .drive(tableView.rx.items(cellIdentifier: MovieTableViewCell.identifier, cellType: MovieTableViewCell.self)) { index, movie, cell in
                cell.resultLabel.text = movie.movieNm
            }
            .disposed(by: disposeBag)

        output.errorMessage
            .compactMap { $0 }
            .drive(with: self) { owner, message in
                owner.showAlert(title: "오류", message: message)
            }
            .disposed(by: disposeBag)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        navigationItem.titleView = searchBar
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        searchBar.placeholder = "예) 20250825"
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: ColorName.backgroundColor)
        tableView.rowHeight = 100
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
