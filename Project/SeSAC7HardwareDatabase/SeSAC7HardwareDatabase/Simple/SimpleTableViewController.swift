//
//  SimpleTableViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/11/25.
//

import UIKit
import SnapKit

class SimpleTableViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension SimpleTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell")!
        
        var content = cell.defaultContentConfiguration()
        cell.backgroundColor = .black
        content.text = "textLabel"
        content.textProperties.color = .systemGreen
        
        content.secondaryText = "Detail !!"
        content.secondaryTextProperties.color = .systemPink
        
        content.image = UIImage(systemName: "star")
        content.imageProperties.tintColor = .yellow
        content.imageToTextPadding = 30
        
        cell.contentConfiguration = content
        
        return cell
    }
}
