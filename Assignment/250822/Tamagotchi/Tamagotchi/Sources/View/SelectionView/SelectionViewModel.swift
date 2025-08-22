//
//  SelectionViewModel.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import Foundation
import RxSwift
import RxCocoa

struct TamagotchiItem {
    let type: TamagotchiType
    let title: String
    let isAvailable: Bool
}

final class SelectionViewModel {
    
    struct Input {
        let itemSelected: Observable<IndexPath>
    }
    
    struct Output {
        let items: Driver<[TamagotchiItem]>
        let selectedItem: Driver<TamagotchiItem>
    }
    
    private let maxItemCount = 21
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let itemsRelay = BehaviorRelay(value: createTamagotchiItems())
        
        let selectedItem = input.itemSelected
            .withLatestFrom(itemsRelay.asObservable()) { indexPath, items in
                return items[indexPath.item]
            }
            .asDriver(onErrorJustReturn: TamagotchiItem(type: .none, title: TamagotchiType.none.selectName, isAvailable: false))
        
        return Output(
            items: itemsRelay.asDriver(),
            selectedItem: selectedItem
        )
    }
    
    private func createTamagotchiItems() -> [TamagotchiItem] {
        var items: [TamagotchiItem] = []
        
        let avilableTypes: [TamagotchiType] = [.cactus, .cloud, .star]
        for type in avilableTypes {
            items.append(TamagotchiItem(type: type, title: type.selectName, isAvailable: true))
        }
        
        for _ in 3..<maxItemCount {
            let unavailable = TamagotchiType.none
            items.append(TamagotchiItem(type: unavailable, title: unavailable.selectName, isAvailable: false))
        }
        
        return items
    }
}
