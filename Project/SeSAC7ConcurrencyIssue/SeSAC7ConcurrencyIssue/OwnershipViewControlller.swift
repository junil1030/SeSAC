//
//  OwnershipViewControlller.swift
//  SeSAC7ConcurrencyIssue
//
//  Created by 서준일 on 11/20/25.
//

import UIKit
import StoreKit

/*
 Copyable: 5.9+ 값 타입의 복사를 정의
 값 타입에는 Copyable Protocol이 이미 정의가 되어 있음.
 
 => 값 타입이 복사할 필요가 없다면? noncopyable type을 사용 == Move only type
 - 컴파일 시점에 복사를 방지하도록 보장
 - 복사로 인한 의도하지 않은 중복, 성능 최적화, 데이터 무결성 등을 보장
 
 => consume consuming borrowing
 */

struct User: ~Copyable {
    let name: String
    let age: Int
    
    deinit { // ~Copyable을 채택해야만 deinit을 할 수 있다.
        print("User Deinitialized")
    }
}

struct Person: ~Copyable {
    let name: String
    let age: Int
    
    func test() {
        print(#function)
    }
    
    consuming func test2() {
        print(#function)
    }
    
    deinit {
        print("Person Deinit")
    }
}

class OwnershipViewControlller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPerson()
        print("viewDidLoad End")
    }
    
    func fetchMovePerson() {
        let person = Person(name: "2026Junil", age: 28)
        print(person.name)
        
        let newPerson = consume person
        print(newPerson.name)
        
        introduce(test: newPerson)
        
        print(newPerson.name)
    }
    
    // consuming: 소유권을 이 함수로 그냥 넘겨버림. 그래서 이후에 접근 불가능
    // borrowing: 소유권을 잠시 빌려줌. 참조만 가능하게 만들어서 읽을 수만 있게 함
    func introduce(test: borrowing Person) {
        print("이름은 \(test.name)이고 나이는 \(test.age)세 입니다.")
    }
    
    func fetchPerson() {
        let person = Person(name: "2026Junil", age: 28)
        
        print(person.name)
        print(person.test2())
        
//        print(#function, person.name)
    }
    
    func fetchUser() {
        let user = User(name: "Junil", age: 27)
        print(user.name)
        
        let newUser = consume user // 소유권 이동
        print(newUser.name)
//        print(user.name)
    }
}
