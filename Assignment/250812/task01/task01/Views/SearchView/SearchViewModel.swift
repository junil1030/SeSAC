//
//  SearchViewModel.swift
//  task01
//
//  Created by 서준일 on 8/12/25.
//

import Foundation

final class SearchViewModel {
    
    let networkManager = NetworkManager.shared
    
    //MARK: - Input
    var inputSearchKeyword = Observable<String?>(nil)
    
    //MARK: - Output
    var outputSearchKeyword = Observable<String>("")
    var outputNetworkError = Observable<NetworkStatus>(.cellular)
    
    //MARK: - Initialize
    init() {
        inputSearchKeyword.lazyBind { [weak self] keyword in
            self?.checkKeyword(keyword)
        }
    }
    
    //MARK: - Private Method
    private func checkKeyword(_ keyword: String?) {
        guard let keyword = keyword, keyword.trimmingCharacters(in: .whitespacesAndNewlines).count > 1 else { return }
        
        let status = networkManager.currentStatus
        guard status.isConnected  else {
            outputNetworkError.value = status
            return
        }
        
        outputSearchKeyword.value = keyword
    }
}
