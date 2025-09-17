//
//  SimpleTableViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/11/25.
//

import UIKit
import SnapKit
import RealmSwift

class SimpleTableViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var list: Results<MoneyTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        // 데이터 가지고 오는 코드
        // 1. Realm 테이블에 접근
        let realm = try! Realm()
        print(realm.configuration.fileURL) // 렘 테이블의 위치
        
        // 2. Realm 테이블에서 데이터를 가져오기
        list = realm.objects(MoneyTable.self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 1. Realm 테이블에 접근
        let realm = try! Realm()
        
        // 2. 저장하려고 하는 데이터를 생성
        let data = MoneyTable(money: .random(in: 10000...50000), type: true, useDate: Date(), category: .random(in: 0...2))
        
        do {
            try realm.write {
                realm.add(data)
                print("저장 성공")
            }
        } catch {
            print("실패 !")
        }
    }
}

extension SimpleTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell")!
        
        var content = cell.defaultContentConfiguration()
        cell.backgroundColor = .black
        content.text = list[indexPath.row].money.formatted() + "원"
        content.textProperties.color = .systemGreen
        
        content.secondaryText = list[indexPath.row].date.formatted()
        content.secondaryTextProperties.color = .systemPink
        
        content.image = UIImage(systemName: "star")
        content.imageProperties.tintColor = .yellow
        content.imageToTextPadding = 30
        
        cell.contentConfiguration = content
        
        return cell
    }
}
