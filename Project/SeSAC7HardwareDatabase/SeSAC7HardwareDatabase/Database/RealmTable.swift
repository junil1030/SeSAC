//
//  RealmTable.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/17/25.
//

import Foundation
import RealmSwift

// 가계부: 금액, 내역, 날짜, 장소, 카테고리, 수입지출여부, 결제 방법
class MoneyTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var money: Int // 금액, Int, 필수
    @Persisted var type: Bool // 수입 true, 지출 false, 필수
    @Persisted var date: Date // 날짜, Date, 필수
    @Persisted var category: Int // 카테고리, Int, 필수 (0: 식비, 1: 생활비, 2: 적금)
    
    @Persisted var place: String? // 장소, String, 옵션
    @Persisted var memo: String? // 지출 내역, String, 옵션
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
