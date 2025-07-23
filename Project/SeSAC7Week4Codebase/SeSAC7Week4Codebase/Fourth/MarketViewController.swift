//
//  MarketViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/23/25.
//

import UIKit
import SnapKit

protocol Mentor {}

class SeSAC {}
class Jack: SeSAC {}
class Bran: SeSAC, Mentor {}
class Hue {}
struct Finn {}
struct Den {}

class MarketViewController: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
    }

}

extension MarketViewController: UITableViewDelegate {
    
    
}

extension MarketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        
        return cell
    }
    
    
}

extension MarketViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .orange
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.identifier)
    }
}
