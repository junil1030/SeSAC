//
//  SearchViewModel.swift
//  task01
//
//  Created by 서준일 on 8/12/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    //MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    
    //MARK: - ObservableCustom Stream
    struct Input {
        var searchBarText: Observable<String>
        var searchButtonClicked: Observable<Void>
    }
    
    struct Output {
        var searchKeyword: Driver<String>
        var showEmptyAlert: Driver<String>
        var showNetworkErrorAlert: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        let searchText = input.searchButtonClicked
            .withLatestFrom(input.searchBarText)
        
        let showEmptyAlert = searchText
            .filter { $0.isEmpty }
            .map { _ in "검색 키워드를 입력해주세요" }
            .asDriver(onErrorJustReturn: "알 수 없는 오류")
        
        let validText = searchText
            .filter { !$0.isEmpty  &&
                $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 1
            }
        
        let validatedText = validText
            .withUnretained(self)
            .map { owner, text in
                return (text: text, isNetworkOk: owner.checkNetwork())
            }
            .share()
        
        let showNetworkErrorAlert = validatedText
            .filter { !$0.isNetworkOk }
            .withUnretained(self)
            .map { owner, _ in
                owner.networkManager.currentStatus.description
            }
            .asDriver(onErrorJustReturn: "")
        
        let searchKeyword = validatedText
            .filter { $0.isNetworkOk }
            .map { $0.text }
            .asDriver(onErrorJustReturn: "")
        
        return Output(searchKeyword: searchKeyword,
                      showEmptyAlert: showEmptyAlert,
                      showNetworkErrorAlert: showNetworkErrorAlert
        )
    }
    
    private func checkNetwork() -> Bool {
        let status = networkManager.currentStatus
        guard status.isConnected else {
            return false
        }
        return true
    }
}
