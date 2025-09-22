//
//  CalendarViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by Jack on 9/18/25.
//

import UIKit
import SnapKit
import RealmSwift

class CalendarViewController: UIViewController {
 
    let tableView = UITableView()
    let calendar = UIView()
    
    // 1. default.realm 조회
    let realm = try! Realm()
    
    var list: [MoneyTable] = []
    
    var folder: MoneyFolder!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        configureHierarchy()
        configureView()
        configureConstraints()
        
        print(realm.configuration.fileURL)
        navigationItem.title = folder.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        let data = realm.objects(MoneyTable.self).where {
//            .where { table in
//            return table.category == 1
            $0.folder == folder!.id
        }.sorted(byKeyPath: "money", ascending: false)
        list = Array(data)
        tableView.reloadData()
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(calendar)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        calendar.backgroundColor = .green
        
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
          
        let image = UIImage(systemName: "plus")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        
        let search = UIImage(systemName: "magnifyingglass")
        let left = UIBarButtonItem(image: search, style: .plain, target: self, action: #selector(searchBarButtonItemClicked))
        
        let deleteAll = UIImage(systemName: "trash.fill")
        let deleteAllItem = UIBarButtonItem(image: deleteAll, style: .plain, target: self, action: #selector(deleteAllButtonItemClicked))
        
        navigationItem.rightBarButtonItems = [item, left, deleteAllItem]
    }
    
    private func configureConstraints() {
        
        calendar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
         
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
     
    @objc func rightBarButtonItemClicked() {
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchBarButtonItemClicked() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func deleteAllButtonItemClicked() {
        let alert = UIAlertController(title: "데이터 초기화", message: "정말로 하시겠습니까?", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "예", style: .default)
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
        
        let data = list[indexPath.row]
        
        cell.titleLabel.text = data.money.formatted() + "원"
        cell.subTitleLabel.text = data.type ? "+" : "-"
        cell.overviewLabel.text = data.memo
        cell.thumbnailImageView.image = loadImageToDocument(filename: "\(data.id)")
        
        return cell
    }
    
//    DB 레코드를 삭제하는 경우에는 레코드와 연결된 파일도 함께 삭제해주는 것이 꼭 필요함 !!!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = list[indexPath.row]
        
        removeImageFromDocument(filename: "\(data.id)")
        
        do {
            try realm.write {
//                여러 즐겨찾기 된 레코드를 한번에 해제하고 싶은 것과 같은 경우, 일괄 컬럼 값을 수정하는 것도 할 수 있음.
//                realm.objects(MoneyTable.self).setValue(<#T##F.ValueType#>, for: <#T##KeyPath<O.Root, F.ValueType>#>)
//                realm.create(MoneyTable.self, value: ["id": data.id, "money": 1], update: .modified)
                
                realm.delete(data)
            }
        } catch {
            print("데이터 삭제 실패")
        }
        
        list = Array(realm.objects(MoneyTable.self))
        tableView.reloadData()
    }
      
    
}
