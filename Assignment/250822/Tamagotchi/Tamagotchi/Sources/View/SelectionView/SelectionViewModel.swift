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
        let startButtonTapped: Observable<TamagotchiItem>
        let cancelButtonTapped: Observable<Void>
    }
    
    struct Output {
        let items: Driver<[TamagotchiItem]>
        let showPopup: Driver<TamagotchiItem>
        let dismissPopup: Driver<Void>
        let navigateToMain: Driver<TamagotchiType>
    }
    
    private let maxItemCount = 21
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let itemsRelay = BehaviorRelay(value: createTamagotchiItems())
        
        let selectedItem = input.itemSelected
            .withLatestFrom(itemsRelay.asObservable()) { indexPath, items in
                return items[indexPath.item]
            }
            .filter { $0.isAvailable}
            .share()
        
        let showPopup = selectedItem
            .asDriver(onErrorJustReturn: TamagotchiItem(type: .none, title: TamagotchiType.none.selectName, isAvailable: false))
        
        let dismissPopup = Observable.merge(
            input.cancelButtonTapped,
            input.startButtonTapped.map { _ in () }
        )
            .asDriver(onErrorJustReturn: ())
        
        let navigateToMain = input.startButtonTapped
            .do(onNext: { [weak self] item in
                self?.saveTamagotchiSelection(item.type)
            })
            .map { $0.type }
            .asDriver(onErrorJustReturn: .none)
        
        return Output(
            items: itemsRelay.asDriver(),
            showPopup: showPopup,
            dismissPopup: dismissPopup,
            navigateToMain: navigateToMain
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
    
    private func saveTamagotchiSelection(_ type: TamagotchiType) {
        DataManager.shared.saveSelectedTamagotchiType(type)
    }
}
