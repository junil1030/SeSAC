//
//  Diary.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/23/25.
//

import Foundation
import RealmSwift

// 새로운 테이블을 만드는 경우에서는 충돌 이슈가 생기지 않고,
// 기존 테이블이 변경될 경우에만 충돌 이슈가 생김
class Diary: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String     // 일기 제목
    @Persisted var memo: String // 일기 내용
    @Persisted var favorite: Bool   // 일기 즐겨찾기
    @Persisted var emotion: Double
    
    convenience init(name: String, contents: String) {
        self.init()
        
        self.name = name
        self.memo = contents
    }
}

class Diary2: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String     // 일기 제목
    @Persisted var contents: String // 일기 내용
    @Persisted var favorite: String // 일기 즐찾
}
