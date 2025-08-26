////
////  ViewModel.swift
////  Tamagotchi
////
////  Created by 서준일 on 8/26/25.
////
//
//import Foundation
//import RxSwift
//import RxCocoa
//
//final class ViewModel: MainViewModelType, MainViewModelInputs, MainViewModelOutputs {
//    
//    private let tamagotchiManager = TamagotchiManager.shared
//    private let dataManager = DataManager.shared
//    private var selectedTamagotchi: TamagotchiItem?
//    
//
//    init() {
//        if let tamagotchiType = dataManager.loadSelectedTamagotchiType() {
//            selectedTamagotchi = TamagotchiItem(
//                type: tamagotchiType,
//                title: tamagotchiType.selectName,
//                isAvailable: true
//            )
//        }
//        
//        // UI 업데이트 트리거
//        let updateUITrigger = Observable.merge(
//            self.viewWillAppearSubject.map { _ in () },
//            self.mealSuccessSubject.map { _ in () },
//            self.dropSuccessSubject.map { _ in () }
//        )
//        
//        // 밥먹기 처리
//        let mealInputResult = self.mealButtonTappedSubject
//            .compactMap { $0 }
//            .map { text in
//                text.isEmpty ? "1" : text
//            }
//            .map { text -> Result<Int, InputValidationType> in
//                guard let amount = Int(text) else {
//                    return .failure(.invalidMealInput)
//                }
//                guard amount > 0 && amount < 100 else {
//                    return .failure(.mealOverLimit)
//                }
//                return .success(amount)
//            }
//            .share()
//        
//        mealInputResult
//            .compactMap { result in
//                switch result {
//                case .success(let amount): return amount
//                case .failure: return nil
//                }
//            }
//            .subscribe(onNext: { [weak self] amount in
//                self?.tamagotchiManager.eatRice(amount)
//                self?.mealSuccessSubject.onNext(())
//            })
//            .disposed(by: disposeBag)
//        
//        // 물먹기 처리
//        let dropInputResult = self.dropButtonTappedSubject
//            .compactMap { $0 }
//            .map { text in
//                text.isEmpty ? "1" : text
//            }
//            .map { text -> Result<Int, InputValidationType> in
//                guard let amount = Int(text) else {
//                    return .failure(.invalidWaterInput)
//                }
//                guard amount > 0 && amount < 50 else {
//                    return .failure(.waterOverLimit)
//                }
//                return .success(amount)
//            }
//            .share()
//        
//        dropInputResult
//            .compactMap { result in
//                switch result {
//                case .success(let amount): return amount
//                case .failure: return nil
//                }
//            }
//            .subscribe(onNext: { [weak self] amount in
//                self?.tamagotchiManager.drinkWater(amount)
//                self?.dropSuccessSubject.onNext(())
//            })
//            .disposed(by: disposeBag)
//        
//        self.title = self.viewWillAppearSubject
//            .map { [weak self] _ in
//                let nickname = self?.tamagotchiManager.nickName ?? "대장"
//                return "\(nickname)님의 다마고치"
//            }
//            .asDriver(onErrorJustReturn: "대장님의 다마고치")
//        
//        self.updateUI = updateUITrigger
//            .compactMap { [weak self] _ in
//                self?.createUIModel()
//            }
//            .asDriver(onErrorJustReturn: ViewModel.createDefaultUIModel())
//        
//        self.showInputValidationAlert = Observable.merge(
//            mealInputResult.compactMap { result in
//                switch result {
//                case .success: return nil
//                case .failure(let error): return error
//                }
//            },
//            dropInputResult.compactMap { result in
//                switch result {
//                case .success: return nil
//                case .failure(let error): return error
//                }
//            }
//        )
//        .asDriver(onErrorJustReturn: .unknown)
//    }
//    
//    //MARK: - Input functions and Subject
//    private let dropButtonTappedSubject = PublishSubject<String?>()
//    public func giveDrop(with text: String?) {
//        dropButtonTappedSubject.onNext(text)
//    }
//    
//    private let mealButtonTappedSubject = PublishSubject<String?>()
//    public func feedMeal(with text: String?) {
//        mealButtonTappedSubject.onNext(text)
//    }
//    
//    private let viewWillAppearSubject = PublishSubject<Bool>()
//    public func viewWillAppear(_ animated: Bool) {
//        viewWillAppearSubject.onNext(animated)
//    }
//    
//    //MARK: - Helper Subject
//    private let dropSuccessSubject = PublishSubject<Void>()
//    private let mealSuccessSubject = PublishSubject<Void>()
//    
//    //MARK: - Input Observers
//    public var dropButtonTapped: Observable<String?> {
//        return dropButtonTappedSubject.asObservable()
//    }
//    
//    public var mealButtonTapped: Observable<String?> {
//        return mealButtonTappedSubject.asObservable()
//    }
//    
//    public var viewWillAppear: Observable<Bool> {
//        return viewWillAppearSubject.asObservable()
//    }
//    
//    //MARK: - Output Properties
//    public let showInputValidationAlert: Driver<InputValidationType>
//    public let title: Driver<String>
//    public let updateUI: Driver<MainViewTamagotchiInfo>
//    
//    //MARK: - Input/Output
//    public var inputs: MainViewModelInputs { return self }
//    public var outputs: MainViewModelOutputs { return self }
//    
//    //MARK: - Dispose
//    private let disposeBag = DisposeBag()
//}
//
//extension ViewModel {
//    func createUIModel() -> MainViewTamagotchiInfo? {
//        guard let tamagotchi = selectedTamagotchi else { return nil }
//        
//        let stats = tamagotchiManager.getCurrentStats()
//        let message = tamagotchiManager.randomMessage(for: tamagotchiManager.nickName)
//        let imageText = tamagotchiManager.imageText
//        
//        return MainViewTamagotchiInfo(
//            tamagotchi: tamagotchi,
//            stats: stats,
//            message: message,
//            imageText: imageText
//        )
//    }
//    
//    static func createDefaultUIModel() -> MainViewTamagotchiInfo {
//        let defaultTamagotchi = TamagotchiItem(
//            type: .cloud,
//            title: "기본 다마고치",
//            isAvailable: true
//        )
//        
//        return MainViewTamagotchiInfo(
//            tamagotchi: defaultTamagotchi,
//            stats: TamagotchiStats(level: 1, mealCount: 0, waterCount: 0),
//            message: "안녕하세요!",
//            imageText: "2-1"
//        )
//    }
//}
