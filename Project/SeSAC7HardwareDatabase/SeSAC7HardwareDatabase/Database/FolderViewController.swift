//
//  FolderViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by Jack on 9/18/25.
//

import UIKit
import SnapKit
import RealmSwift

class FolderViewController: UIViewController {
    
    private var realm = try! Realm()

    let tableView = UITableView()
    
    var list: Results<MoneyFolder>!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        configureConstraints()
        
        print(realm.configuration.fileURL)
        
        list = realm.objects(MoneyFolder.self)
        
//        dump(list)
//        
//        createFolder(name: "가족")
//        createFolder(name: "개인")
//        createFolder(name: "동아리")
//        createFolder(name: "회사")
        
//        createAccount(title: "재료 1")
//        createAccount(title: "커피 12")
//        createAccount(title: "술 30")
//        createAccount(title: "안주 8")
        
//        createMemo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func createMemo() {
        let folder = realm.objects(MoneyFolder.self).where {
            $0.name == "동아리"
        }.first!
        
        let memo = Memo()
        memo.editDate = Date()
        memo.regDate = Date()
        memo.memoContents = "2025 상반기에 참여한 동아리"
        memo.memoMusic = "빅뱅, 2NE1"
        
        do {
            try realm.write {
                folder.memo = memo
            }
        } catch {
            print("렘 테이블에 저장 실패")
        }
    }
    
    func createAccount(title: String) {
        
        let account = Account(title: title)
        
        let folder = realm.objects(MoneyFolder.self).where {
            $0.name == "동아리"
        }.first!
        
        do {
            try realm.write {
                folder.detail.append(account)
            }
        } catch {
            print("렘 데이터에 저장 실패")
        }
        
//        let account = Account(title: title)
//        
//        do {
//            try realm.write {
//                realm.add(account)
//            }
//        } catch {
//            print("폴더 테이블에 저장 실패")
//        }
    }
    
    private func createFolder(name: String) {
        
        let folder = MoneyFolder(name: name)
        
        do {
            try realm.write {
                realm.add(folder)
            }
        } catch {
            print("폴더 테이블에 저장 실패")
        }
    }

    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    private func configureView() {
        view.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
    }
     
    private func configureConstraints() {
         
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as! ListTableViewCell
        let data = list[indexPath.row]
        cell.titleLabel.text = data.name
        cell.subTitleLabel.text = "\(data.detail.count)"
        cell.overviewLabel.text = data.memo?.memoContents
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 개인을 삭제하고 개인 안에 4개의 레코드도 같이 제거하고 싶음
//        let data = list[indexPath.row]
//        
//        do {
//            try realm.write {
//                realm.delete(data.detail)
//                realm.delete(data)
//            }
//        } catch {
//            print("렘 데이터 삭제 실패")
//        }
        
//        let vc = SearchViewController()
//        let data = list[indexPath.row]
//        vc.account = data.detail
//        navigationController?.pushViewController(vc, animated: true)
    }
}
