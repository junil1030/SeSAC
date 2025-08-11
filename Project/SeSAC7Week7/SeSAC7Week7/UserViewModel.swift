//
//  UserViewModel.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/8/25.
//

import Foundation

class UserViewModel {
    
    let loadButtonTapped: Field<Void> = Field(())
    let resetButtonTapped: Field<Void> = Field(())
    let addButtonTapped: Field<Void> = Field(())
    
    let list: Field<[Person]> = Field([])
    
    init() {
        print("UserViewModel Init")
        
        loadButtonTapped.playAction { _ in
            self.load()
        }
        
        resetButtonTapped.playAction { _ in
            self.reset()
        }
        
        addButtonTapped.playAction { _ in
            self.add()
        }
    }
    
    private func load() {
        list.value = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func reset() {
        list.value.removeAll()
    }
    
    private func add() {
        let jack = Person(name: "Jack", age: Int.random(in: 1...100))
        list.value.append(jack)
    }
    
    func cellForRowAtData(at indexPath: IndexPath) -> String {
        let person = list.value[indexPath.row]
        return "\(person.name), \(person.age)세"
    }
}
