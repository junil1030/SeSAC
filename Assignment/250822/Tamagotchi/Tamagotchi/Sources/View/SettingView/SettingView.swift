//
//  SettingView.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/24/25.
//

import UIKit
import SnapKit

final class SettingView: BaseView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor(named: ColorName.backgroundColor)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray5
        tableView.rowHeight = 60
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.separatorColor = UIColor(named: ColorName.textColor)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    override func setupHierachy() {
        super.setupHierachy()
        
        addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
    }
}
