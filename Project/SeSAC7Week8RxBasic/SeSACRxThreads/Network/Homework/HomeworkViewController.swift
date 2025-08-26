//
//  HomeworkViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import Alamofire
import SnapKit
import RxSwift
import RxCocoa

class HomeworkViewController: UIViewController {
    
    let tableView = UITableView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    let searchBar = UISearchBar()
    
    let disposeBag = DisposeBag()
    
    let list: BehaviorRelay<[Lotto]> = BehaviorRelay(value: [])
    let items = BehaviorRelay(value: ["a", "b", "c"])
    
    private let viewModel = HomeworkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        
        let input = HomeworkViewModel.Input(
            searchTap: searchBar.rx.searchButtonClicked,
            searchText: searchBar.rx.text.orEmpty,
            cellSelected: tableView.rx.modelSelected(Lotto.self)
        )
        let output = viewModel.transform(input: input)
        
        output.list
            .bind(to: tableView.rx.items(cellIdentifier: PersonTableViewCell.identifier, cellType: PersonTableViewCell.self)) { row, element, cell in
                let text = "\(element.drwNoDate)일, \(element.firstAccumamnt.formatted())원"
                cell.usernameLabel.text = text
            }
            .disposed(by: disposeBag)
        
        output.items
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)) { row, element, cell in
                cell.label.text = element
            }
            .disposed(by: disposeBag)
        
        output.showAlert
            .bind(with: self) { owner, result in
                if result { print("얼럿 띄우기") }
            }
            .disposed(by: disposeBag)
    }
    
    func hide() {
        // 커스텀 옵저버블을 활용해서, 서치 탭 시 랜덤으로 숫자를 추가
        //        searchBar.rx.searchButtonClicked
        //            .map {
        //                return CustomObservable.randomNumber()
        //            }
        //            .bind(with: self) { owner, value in
        //                value
        //                    .bind(with: self) { owner, number in
        //                        var data = owner.list.value
        //                        data.insert(number, at: 0)
        //
        //                        owner.list.accept(data)
        //                    }
        //                    .disposed(by: owner.disposeBag)
        //            }
        //            .disposed(by: disposeBag)
        
        //        searchBar.rx.searchButtonClicked
        //            .flatMap {
        //                CustomObservable.randomNumber()
        //                    .debug("랜덤넘버 옵저버블")
        //            }
        //            .debug("서치바 옵저버블")
        //            .bind(with: self) { owner, number in
        //                var data = owner.list.value
        //                data.insert(number, at: 0)
        //                owner.list.accept(data)
        //            }
        //            .disposed(by: disposeBag)
        
        //        searchBar.rx.searchButtonClicked
        //            .withLatestFrom(searchBar.rx.text.orEmpty)
        //            .map { Int($0) ?? 0 }
        //            .bind(with: self) { owner, text in
        //                var data = owner.list.value
        //                data.insert(text, at: 0)
        //                owner.list.accept(data)
        //            }
        //            .disposed(by: disposeBag)
        
        //        CustomObservable.randomNumber()
        //            .bind(with: self) { owner, number in
        //                owner.list.accept([number])
        //            }
        //            .disposed(by: disposeBag)
        //
        //        CustomObservable.recommendNickname()
        //            .bind(with: self) { owner, nickname in
        //                owner.items.accept([nickname])
        //            }
        //            .disposed(by: disposeBag)
        //
        //        CustomObservable.recommendNickname()
        //            .subscribe(with: self) { owner, value in
        //                owner.items.accept([value])
        //                print("onNext", value)
        //            } onError: { owner, error in
        //                print("onError", error, owner)
        //            } onCompleted: { owner in
        //                print("OnComplete", owner)
        //            } onDisposed: { owner in
        //                print("OnDiposed", owner)
        //            }
        //            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
         
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }

}
 
