////
////  MainViewModelProtocolPractice.swift
////  Tamagotchi
////
////  Created by 서준일 on 8/26/25.
////
//
//import Foundation
//import RxSwift
//import RxCocoa
//
//enum InputValidationType: Error {
//    case mealOverLimit
//    case waterOverLimit
//    case invalidMealInput
//    case invalidWaterInput
//    case unknown
//    
//    var alertInfo: (title: String, message: String) {
//        switch self {
//        case .mealOverLimit:
//            return ("입력 제한", "밥은 최대 99개까지만 줄 수 있어요!")
//        case .waterOverLimit:
//            return ("입력 제한", "물은 최대 49개까지만 줄 수 있어요!")
//        case .invalidMealInput:
//            return ("잘못된 입력", "밥의 개수는 숫자로만 입력해주세요!")
//        case .invalidWaterInput:
//            return ("잘못된 입력", "물의 개수는 숫자로만 입력해주세요!")
//        case .unknown:
//            return ("오류", "알 수 없는 오류가 발생했습니다.")
//        }
//    }
//}
//
//struct MainViewTamagotchiInfo {
//    let tamagotchi: TamagotchiItem
//    let stats: TamagotchiStats
//    let message: String
//    let imageText: String
//}
//
//protocol MainViewModelInputs {
//    var mealButtonTapped: Observable<String?> { get }
//    var dropButtonTapped: Observable<String?> { get }
//    var viewWillAppear: Observable<Bool> { get }
//}
//
//protocol MainViewModelOutputs {
//    var updateUI: Driver<MainViewTamagotchiInfo> { get }
//    var title: Driver<String> { get }
//    var showInputValidationAlert: Driver<InputValidationType> { get }
//}
//
//protocol MainViewModelType {
//    var inputs: MainViewModelInputs { get }
//    var outputs: MainViewModelOutputs { get }
//}
//
//extension MainViewController {
//    func showInputValidationAlert(for type: InputValidationType) {
//        let (title, message) = type.alertInfo
//        showAlert(title: title, message: message)
//    }
//}
