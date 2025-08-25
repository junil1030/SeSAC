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
    
    private let disposeBag = DisposeBag()
    
    private var movieList: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    
    override func setupBind() {
        super.setupBind()
        
        movieList
            .bind(to: tableView.rx.items(cellIdentifier: MovieTableViewCell.identifier, cellType: MovieTableViewCell.self)) { row, element, cell in
                cell.resultLabel.text = element.movieNm
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getDailyBoxOffice(date: text)
            }
            .subscribe(with: self) { owner, value in
                var data = owner.movieList.value
                data.append(contentsOf: value)
                
                owner.movieList.accept(data)
            } onError: { owner, error in
                print("onError", error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
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
