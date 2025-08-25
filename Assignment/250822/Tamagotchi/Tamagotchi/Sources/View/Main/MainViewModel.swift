//
//  MainViewModel.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewTamagotchiInfo {
    let tamagotchi: TamagotchiItem
    let stats: TamagotchiStats
    let message: String
    let imageText: String
}

final class MainViewModel {
    
    private let tamagotchiManager = TamagotchiManager.shared
    private let dataManager = DataManager.shared
    private let disposeBag = DisposeBag()
    private var selectedTamagotchi: TamagotchiItem?
    
    struct Input {
        let mealButtonTapped: Observable<String?>
        let dropButtonTapped: Observable<String?>
        let viewWillAppear: Observable<Bool>
    }
    
    struct Output {
        let updateUI: Driver<MainViewTamagotchiInfo>
        let title: Driver<String>
        let showInputValidationAlert: Driver<MainViewController.InputValidationType>
    }
    
    func transform(input: Input) -> Output {
        
        let updateUIRelay = PublishRelay<Void>()
        let showAlertRelay = PublishRelay<MainViewController.InputValidationType>()
        
        setupSelectedTamagotchi()
        
        let validMealInput = input.mealButtonTapped
            .compactMap { $0 }
            .map { text in
                if text.isEmpty {
                    return "1"
                }
                
                return text
            }
            .share()
        
        validMealInput
            .subscribe(with: self, onNext: { owner, text in
                guard let amount = Int(text) else {
                    showAlertRelay.accept(.invalidMealInput)
                    return
                }
                
                if amount <= 0 {
                    showAlertRelay.accept(.invalidMealInput)
                    return
                }
                
                if amount > 99 {
                    showAlertRelay.accept(.mealOverLimit)
                    return
                }
                
                owner.tamagotchiManager.eatRice(amount)
                updateUIRelay.accept(())
                
                if owner.tamagotchiManager.isMaxLevel == true {
                    print("다마고치가 최대 레벨에 도달했습니다")
                }
            })
            .disposed(by: disposeBag)

        
        let validDropInput = input.dropButtonTapped
            .compactMap { $0 }
            .map { text in
                if text.isEmpty {
                    return "1"
                }
                
                return text
            }
            .share()
        
        validDropInput
            .subscribe(with: self, onNext: { owner, text in
                guard let amount = Int(text) else {
                    showAlertRelay.accept(.invalidWaterInput)
                    return
                }
                
                if amount <= 0 {
                    showAlertRelay.accept(.invalidWaterInput)
                    return
                }
                
                if amount > 49 {
                    showAlertRelay.accept(.waterOverLimit)
                    return
                }
                
                owner.tamagotchiManager.drinkWater(amount)
                updateUIRelay.accept(())
                
                if owner.tamagotchiManager.isMaxLevel == true {
                    print("다마고치가 최대 레벨에 도달했습니다")
                }
            })
            .disposed(by: disposeBag)
        
        input.viewWillAppear
            .map { _ in () }
            .bind(to: updateUIRelay)
            .disposed(by: disposeBag)
        
        let title = input.viewWillAppear
            .withUnretained(self)
            .map { owner, _ in
                return "\(owner.tamagotchiManager.nickName)님의 다마고치"
            }
            .asDriver(onErrorJustReturn: "대장님의 다마고치")
        
        let uiModel = updateUIRelay
            .withUnretained(self)
            .compactMap { owner, _ in
                guard let tamagotchi = owner.selectedTamagotchi else { return nil }
                
                let stats = owner.tamagotchiManager.getCurrentStats()
                let message = owner.tamagotchiManager.randomMessage(for: owner.tamagotchiManager.nickName)
                let imageText = owner.tamagotchiManager.imageText
                
                return MainViewTamagotchiInfo(
                    tamagotchi: tamagotchi,
                    stats: stats,
                    message: message,
                    imageText: imageText
                )
            }
            .asDriver(onErrorJustReturn: createDefaultUIModel())
        
        let showInputValidationAlert = showAlertRelay
            .asDriver(onErrorJustReturn: .invalidMealInput)
        
        return Output(
            updateUI: uiModel,
            title: title,
            showInputValidationAlert: showInputValidationAlert
        )
    }
    
    private func setupSelectedTamagotchi() {
        guard let tamagotchiType = dataManager.loadSelectedTamagotchiType() else { return }
        
        selectedTamagotchi = TamagotchiItem(
            type: tamagotchiType,
            title: tamagotchiType.selectName,
            isAvailable: true
        )
    }
    
    private func createDefaultUIModel() -> MainViewTamagotchiInfo {
        let defaultTamagotchi = TamagotchiItem(
            type: .cloud,
            title: "기본 다마고치",
            isAvailable: true
        )
        
        return MainViewTamagotchiInfo(
            tamagotchi: defaultTamagotchi,
            stats: TamagotchiStats(level: 1, mealCount: 0, waterCount: 0),
            message: "안녕하세요!",
            imageText: "2-1"
        )
    }
}
