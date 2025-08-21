//
//  TableRxViewController.swift
//  task01
//
//  Created by 서준일 on 8/19/25.
//

import UIKit
import RxSwift
import RxCocoa

final class TableRxViewController: UIViewController {
    
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.register(RxTableViewCell.self, forCellReuseIdentifier: RxTableViewCell.identifier)
        
        setupBind()
    }
    
    private func setupBind() {
        let items = Observable.just(
            (0..<100).map { "\($0)" }
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "RxTableViewCell", cellType: RxTableViewCell.self)) { (row, element, cell) in
                cell.configure(with: element, row: row)
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                print("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                print("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)

    }
}
