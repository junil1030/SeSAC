//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 8/1/24.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController {
    
    let disposeBag = DisposeBag()
   
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    
    let searchBar = UISearchBar()

    let data = [
        "First Item",
        "Second Item",
        "Third Item"
    ]
    lazy var items = Observable.just(data)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setSearchController()
        bind()
        
        operatorTest()
    }
    
    func operatorTest() {
        let mentor = Observable.of("Hue", "Jack", "Finn")
        let age = Observable.of(10, 20, 30)
        
        /*
         zip: 두 옵저버블이 모두 변화할 때 이벤트가 방출됨
         combineLatest: 두 옵저버블 중 하나만 바껴도 이벤트가 방출됨
         */
        
        /*
         bind()
         ("Hue", 10)
         ("Jack", 20)
         ("Finn", 30)
         */
//        Observable.zip(
//            mentor,
//            age
//        )
//        .bind(with: self) { owner, value in
//            print(value)
//        }
//        .disposed(by: disposeBag)
        
        /*
         bind()
         ("Hue", 10)
         ("Jack", 10)
         ("Jack", 20)
         ("Finn", 20)
         ("Finn", 30)
         */
        Observable.combineLatest(
            mentor,
            age
        )
        .bind(with: self) { owner, value in
            print(value)
        }
        .disposed(by: disposeBag)
    }
    
    func bind() {
        print(#function)

        items
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
            cell.appNameLabel.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)

//        tableView.rx.itemSelected
//            .bind(with: self) { owner, indexPath in
//                print(indexPath)
//                print(owner.data[indexPath.row])
//            }
//            .disposed(by: disposeBag)
//        
//        tableView.rx.modelSelected(String.self)
//            .bind(with: self) { owner, value in
//                print(value)
//            }
//            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            tableView.rx.itemSelected,
            tableView.rx.modelSelected(String.self)
        )
        .bind(with: self) { owner, value in
            print(value.0)
            print(value.1)
        }
        .disposed(by: disposeBag)
    }
     
    private func setSearchController() {
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(plusButtonClicked))
    }
    
    @objc func plusButtonClicked() {
        print("추가 버튼 클릭")
    }

    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}
