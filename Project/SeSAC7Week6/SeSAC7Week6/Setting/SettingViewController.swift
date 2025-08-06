//
//  SettingViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import UIKit
import SnapKit

enum Setting: String, CaseIterable {
    case setting = "설정"
    case push = "푸시설정"
    case version = "버전정보"
    case personal = "개인정보"
    
    var detail: [String] {
        switch self {
        case .setting:
            return ["알림", "채팅", "친구"]
        case .push:
            return ["푸시푸시", "몰라몰라", "받을까말까"]
        case .version:
            return ["개인정보처리방침", "오픈소스라이센스", "기타"]
        case .personal:
            return ["프로필 수정", "회원탈퇴"]
        }
    }
}

class SettingViewController: UIViewController {
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Setting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Setting.allCases[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases[section].detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        let row = Setting.allCases[indexPath.section].detail[indexPath.row]
        cell.settingLabel.text = row
        
        return cell
        
    }
}


extension SettingViewController {
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configureView() {
        navigationItem.title = "네비게이션 타이틀"
        view.backgroundColor = .white
    }
}
