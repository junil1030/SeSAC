//
//  ResultViewModel.swift
//  task01
//
//  Created by 서준일 on 8/12/25.
//

import Foundation

class ResultViewModel {
    
    //MARK: - Properties
    private let searchKeyword: String
    private let itemsPerPage = 30
    
    private var currentPage = 1
    private var lastPage = 1
    
    //MARK: - Observables
    let shoppingItems = Observable<[ShoppingItem]>([])
    let totalCount = Observable<Int>(0)
    let isAPILoading = Observable<Bool>(false)
    let searchResultText = Observable<String>("검색 중..")
    let currentSortType = Observable<SortType>(.sim)
    let errorMessage = Observable<String?>(nil)
    
    //MARK: - Initialize
    init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
    }
        
    //MARK: - Methods
    func loadData(sort: SortType = .sim, isPagination: Bool = false) {
        guard !isAPILoading.value else { return }
        isAPILoading.value = true
        
        if !isPagination {
            currentSortType.value = sort
            currentPage = 1
            searchResultText.value = "검색 중.."
        }
        
        let startIndex = ((currentPage - 1) * itemsPerPage) + 1
        
        APIService.shared.searchProduct(keyword: searchKeyword, sort: sort, start: startIndex ,display: itemsPerPage) { [weak self] response in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isAPILoading.value = false
                
                switch response {
                case .success(let success):
                    self.handleSuccess(success, isPagination: isPagination)
                case .error(let errorCode, let error):
                    self.handleError(errorCode: errorCode, error: error)
                }
            }
        }
    }
    
    func shouldLoadMoreData(for index: Int) -> Bool {
        return index >= shoppingItems.value.count - 3 && currentPage <= lastPage && !isAPILoading.value
    }
    
    func getItemCount() -> Int {
        return shoppingItems.value.count
    }
    
    func getItem(at index: Int) -> ShoppingItem? {
        guard index < shoppingItems.value.count else { return nil }
        return shoppingItems.value[index]
    }
    
    func getSearchKeyword() -> String {
        return searchKeyword
    }
    
    func loadMoreDataIfNeeded(for index: Int) {
        if shouldLoadMoreData(for: index) {
            loadData(sort: currentSortType.value, isPagination: true)
        }
    }
    
    //MARK: - Private Methods
    private func handleSuccess(_ data: ShoppingResponse, isPagination: Bool) {
        let receivedItems = data.items
        
        lastPage = (data.total + itemsPerPage - 1) / itemsPerPage
        
        if isPagination {
            var updatedItems = shoppingItems.value
            updatedItems.append(contentsOf: receivedItems)
            shoppingItems.value = updatedItems
        } else {
            shoppingItems.value = receivedItems
            totalCount.value = data.total
            searchResultText.value = "\(data.total.formattedString) 개의 검색 결과"
        }
        
        if currentPage <= lastPage {
            currentPage += 1
        }
    }
    
    private func handleError(errorCode: Int, error: Error) {
        searchResultText.value = "검색 실패"
        errorMessage.value = "에러: \(error)\nErrorCode: \(errorCode)"
    }
}
