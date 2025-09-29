//
//  AccountRepository.swift
//  SeSAC7LaunchProject
//
//  Created by 서준일 on 9/25/25.
//

import Foundation
import RealmSwift

final class AccountRepository: JunRepository {

    func createItem() {
        <#code#>
    }
    
    func readItem() -> Account {
        return realm.objects(Account.self).first!
    }
    
    func readAllItemCount() {
        <#code#>
    }
    
    func deleteItem() {
        <#code#>
    }
    
    let realm = try! Realm()
    
    func createAccount(title: String, folder: ObjectId) {
        
        //레코드 만들고
        let data = Account(type: .random(),
                           money: Int.random(in: 100...5000) * 100,
                           title: title)
        
        //가계부 내용을 폴더와 연결 짓기
        let folder = realm.objects(MoneyFolder.self).where {
            $0.id == folder
        }.first!
        
//        if let image = photoImageView.image {
//            saveImageToDocument(image: image, filename: "\(data.id)")
//        }
        
        do {
            try realm.write {
                folder.detail.append(data)
            }
        } catch {
            print("데이터 저장 실패")
        }
        
    }
    
}
