//
//  SearchViewModel.swift
//  task01
//
//  Created by 서준일 on 8/12/25.
//

import Foundation

final class SearchViewModel {
    
    //MARK: - Properties
    let networkManager = NetworkManager.shared
    
    var input: Input
    var output: Output
    
    //MARK: - Observable Stream
    struct Input {
        var searchKeyword = Observable<String?>(nil)
    }
    
    struct Output {
        var searchKeyword = Observable<String>("")
        var networkError = Observable<NetworkStatus>(.cellular)
    }
    
    //MARK: - Initialize
    init() {
        input = Input()
        output = Output()
        
        setupBind()
    }
    
    //MARK: - Private Method
    private func setupBind() {
        input.searchKeyword.lazyBind { [weak self] keyword in
            self?.checkKeyword(keyword)
        }
    }
    
    private func checkKeyword(_ keyword: String?) {
        guard let keyword = keyword, keyword.trimmingCharacters(in: .whitespacesAndNewlines).count > 1 else { return }
        
        let status = networkManager.currentStatus
        guard status.isConnected  else {
            output.networkError.value = status
            return
        }
        
        output.searchKeyword.value = keyword
    }
}
