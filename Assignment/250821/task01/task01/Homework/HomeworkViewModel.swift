//
//  HomeworkViewModel.swift
//  task01
//
//  Created by 서준일 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeworkViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let tableUserData = BehaviorRelay(value: Person.sampleUsers)
    private let collectionUserData = BehaviorRelay<[Person]>(value: [])
    
    struct Input {
        let tableViewItemSelected: Observable<Person>
        let searchButtonTapped: Observable<String>
    }
    
    struct Output {
        let tableViewUserData: Observable<[Person]>
        let collectionViewUserData: Observable<[Person]>
        let navigateToPerson: Observable<Person>
    }
    
    init() {
        
    }
    
    func transform(input: Input) -> Output {
        let addToCollection = input.tableViewItemSelected
            .withLatestFrom(collectionUserData) { selectedPerson, currentUsers in
                var newUsers = currentUsers
                newUsers.append(selectedPerson)
                return Array(Set(newUsers))
            }
        
        addToCollection
            .bind(to: collectionUserData)
            .disposed(by: disposeBag)
        
        let addNewUser = input.searchButtonTapped
            .filter { !$0.isEmpty }
            .map { saerchText in
                self.createNewPerson(name: saerchText)
            }
            .withLatestFrom(tableUserData) { newUser, currentUsers in
                var newUsers = currentUsers
                newUsers.append(newUser)
                return newUsers
            }
        
        addNewUser
            .bind(to: tableUserData)
            .disposed(by: disposeBag)
        
        let navigateToPerson = input.tableViewItemSelected
        
        return Output(
            tableViewUserData: tableUserData.asObservable(),
            collectionViewUserData: collectionUserData.asObservable(),
            navigateToPerson: navigateToPerson
        )
    }
    
    private func createNewPerson(name: String) -> Person {
        let gender = Bool.random() ? "men" : "women"
        let number = Int.random(in: 26...100)
        return Person(
            name: name,
            email: "sample@sample.com",
            profileImage: "https://randomuser.me/api/portraits/thumb/\(gender)/\(number).jpg"
        )
    }
}
