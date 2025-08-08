//
//  UserViewModel.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/8/25.
//

import Foundation

class UserViewModel {
    
    // 저장 프로퍼티
    // var nickname = "고래밥"
    
    // 연산 프로퍼티
    // var nickname: String { }
    
    // =으로 구분하면 편함
    
    // 인스턴스 저장 프로퍼티에 있는 내용이 바뀔 때 마다 무어낙의 신호를 받고 싶다.
    private(set) var list: [Person] = [] {
        didSet {
            onDataChanged?()
        }
    }
    
    var onLoadClicked: (() -> Void)?
    var onResetClicked: (() -> Void)?
    var onAddClicked: (() -> Void)?
    
    var onDataChanged: (() -> Void)?
    
    private func load() {
        list = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func reset() {
        list.removeAll()
    }
    
    private func add() {
        let jack = Person(name: "Jack", age: Int.random(in: 1...100))
        list.append(jack)
    }
    
    func cellForRowAtData(at indexPath: IndexPath) -> Person {
        return list[indexPath.row]
    }
}
