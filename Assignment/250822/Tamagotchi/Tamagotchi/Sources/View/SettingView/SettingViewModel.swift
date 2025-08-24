//
//  SettingViewModel.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel {
    
    struct Input {
        let itemSelected: Observable<IndexPath>
        let resetConfirmed: Observable<Void>
    }
    
    struct Output {
        let items: Driver<[SettingItem]>
        let changeNickname: Driver<Void>
        let changeTamagotchi: Driver<Void>
        let resetData: Driver<Void>
        let resetConfirm: Driver<Void>
    }
    
    private let dataManager = DataManager.shared
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let items = createSettingItems()
        let itemsDriver = Driver.just(items)
        
        let selectedItemType = input.itemSelected
            .map { indexPath in
                return items[indexPath.row].type
            }
            .share()
        
        let changeNickname = selectedItemType
            .filter { $0 == .nickname }
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())
        
        let changeTamagotchi = selectedItemType
            .filter { $0 == .changeTamagotchi }
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())
        
        let resetData = selectedItemType
            .filter { $0 == .resetData }
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())
        
        let resetConfirmed = input.resetConfirmed
            .withUnretained(self) { owner, _ in
                owner.dataManager.resetAllData()
            }
            .asDriver(onErrorJustReturn: ())
        
        return Output(items: itemsDriver,
                      changeNickname: changeNickname,
                      changeTamagotchi: changeTamagotchi,
                      resetData: resetData,
                      resetConfirm: resetConfirmed
        )
    }
    
    private func createSettingItems() -> [SettingItem] {
        return [
            SettingItem(type: .nickname),
            SettingItem(type: .changeTamagotchi),
            SettingItem(type: .resetData)
        ]
    }
}
