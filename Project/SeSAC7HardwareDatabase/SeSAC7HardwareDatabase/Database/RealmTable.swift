//
//  RealmTable.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/17/25.
//

import Foundation
import RealmSwift

final class MoneyFolder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String // 폴더명
    @Persisted var regdate: Date // 폴더 생성일
    
    @Persisted var detail: List<Account> // 폴더 테이블 내에 Account테이블 들어 있음
    // 1:N Relationship
    
    // 항상 옵셔널 선언.
    // 테이블이 생기는 건 아님
    @Persisted var memo: Memo?
    
    convenience init(name: String) {
        self.init()
        
        self.name = name
        self.regdate = Date()
    }
}

// To-One Relationship
class Memo: EmbeddedObject {
    @Persisted var memoContents: String
    @Persisted var memoKeyword: String
    @Persisted var memoMusic: String
    @Persisted var regDate: Date
    @Persisted var editDate: Date
}

class Account: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var money: Int
    @Persisted var title: String
    
    // Inverse Relationship
    @Persisted(originProperty: "detail")
    var folder: LinkingObjects<MoneyFolder>
    
    convenience init(title: String) {
        self.init()
        
        self.money = Int.random(in: 1...1000) * 100
        self.title = title
    }
}

// 가계부: 금액, 내역, 날짜, 장소, 카테고리, 수입지출여부, 결제 방법
class MoneyTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var folder: ObjectId // 어떤 폴더인지?
    
    @Persisted var money: Int // 금액, Int, 필수
    @Persisted var type: Bool // 수입 true, 지출 false, 필수
    @Persisted var date: Date // 날짜, Date, 필수
    @Persisted var category: Int // 카테고리, Int, 필수 (0: 식비, 1: 생활비, 2: 적금)
    
    @Persisted var title: String? // 핵심 내용, String, 옵션
    @Persisted var place: String? // 장소, String, 옵션
    @Persisted(indexed: true) var memo: String? // 지출 내역, String, 옵션
    @Persisted var card: Bool? // 결제 방법, 카드 true, 현금 false, 옵션
    
    convenience init(money: Int, type: Bool, useDate: Date, category: Int, place: String? = nil, memo: String? = nil, card: Bool? = nil) {
        self.init()
        
        self.money = money
        self.type = type
        self.date = useDate
        self.category = category
        self.place = place
        self.memo = memo
        self.card = card
    }
}
