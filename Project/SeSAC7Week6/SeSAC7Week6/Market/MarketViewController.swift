//
//  MarketViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import UIKit
import SnapKit

final class MarketViewController: UIViewController {

    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.identifier)
        return tableView
    }()
   
    var list: [Coin] = [
        Coin(market: "비트코인", korean_name: "코인", english_name: "Coin"),
        Coin(market: "이더리움", korean_name: "이더", english_name: "Eth"),
        Coin(market: "비트코인", korean_name: "비트", english_name: "BTC")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func callRequest() {
        NetworkManager.shared.callRequest { value in
            self.list = value
            self.tableView.reloadData()
        }
     
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        let row = list[indexPath.row]
        cell.nameLabel.text = row.coinOverview
        cell.backgroundColor = .blue
        
        return cell
    }
    
}

extension MarketViewController {
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
    }
}

