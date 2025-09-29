//
//  FolderRepository.swift
//  SeSAC7LaunchProject
//
//  Created by 서준일 on 9/25/25.
//

import Foundation
import RealmSwift

protocol JunRepository {
    
    associatedtype Item
    
    func createItem()
    func readItem() -> Item
    func readAllItemCount()
    func deleteItem()
}

final class FolderRepository: JunRepository {
    
    func createItem() {
        <#code#>
    }
    
    func readItem() -> MoneyFolder {
        return readFolder(name: "동아리")
    }
    
    func readAllItemCount() {
        <#code#>
    }
    
    func deleteItem() {
        <#code#>
    }
    
    
    let realm = try! Realm()
    
    func createFolder(name: String) {
        
        let folder = MoneyFolder(name: name)
        
        do {
            try realm.write {
                realm.add(folder)
            }
        } catch {
            print("폴더 테이블에 저장 실패")
        }
        
    }
    
    func readFolder(name: String) -> MoneyFolder {
        let folder = realm.objects(MoneyFolder.self).where {
            $0.name == name
        }.first!
        
        return folder
    }

    func createMoney(title: String) {
        
        let account = Account(type: false, money: .random(in: 100...50000), title: title)
        
        let folder = readFolder(name: "동아리")
        
        do {
            try realm.write {
                folder.detail.append(account)
            }
        } catch {
            print("렘 데이터에 저장 실패")
        }
    }
    
    func readFolderAllCount() ->  Int {
        return realm.objects(MoneyFolder.self).count
    }
    
    func readFolderList() ->  Results<MoneyFolder> {
        return realm.objects(MoneyFolder.self)
    }
    
    func createDummy() {
        let folder = realm.objects(MoneyFolder.self).count
        
        if folder == 0 {
            createFolder(name: "개인")
            createFolder(name: "회사")
            createFolder(name: "동아리")
            createFolder(name: "가족")
            
            createMoney(title: "대관비")
            createMoney(title: "스티커제작비용")
            createMoney(title: "음료수")
        }
    }

}
