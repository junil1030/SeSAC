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
    
    var input: Input
    var output: Output
    
    //MARK: - Observables Streams
    struct Input {
        let loadData = Observable<SortType>(.sim)
        let loadMoreData = Observable<Int>(0)
    }
    
    struct Output {
        let shoppingItems = Observable<[ShoppingItem]>([])
        let totalCount = Observable<Int>(0)
        let isAPILoading = Observable<Bool>(false)
        let searchResultText = Observable<String>("검색 중..")
        let currentSortType = Observable<SortType>(.sim)
        let errorMessage = Observable<String?>(nil)
    }
    
    //MARK: - Initialize
    init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
        
        input = Input()
        output = Output()
        
        setupBind()
    }
        
    //MARK: - Methods
    func getItemCount() -> Int {
        return output.shoppingItems.value.count
    }
    
    func getItem(at index: Int) -> ShoppingItem? {
        guard index < output.shoppingItems.value.count else { return nil }
        return output.shoppingItems.value[index]
    }
    
    func getSearchKeyword() -> String {
        return searchKeyword
    }
    
    //MARK: - Private Methods
    private func setupBind() {
        input.loadData.bind { [weak self] type in
            self?.loadData(sort: type)
        }
        
        input.loadMoreData.bind { [weak self] index in
            self?.loadMoreDataIfNeeded(for: index)
        }
    }
    
    private func loadData(sort: SortType = .sim, isPagination: Bool = false) {
        guard !output.isAPILoading.value else { return }
        output.isAPILoading.value = true
        
        if !isPagination {
            output.currentSortType.value = sort
            currentPage = 1
            output.searchResultText.value = "검색 중.."
        }
        
        let startIndex = ((currentPage - 1) * itemsPerPage) + 1
        
        APIService.shared.searchProduct(keyword: searchKeyword, sort: sort, start: startIndex ,display: itemsPerPage) { [weak self] response in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.output.isAPILoading.value = false
                
                switch response {
                case .success(let success):
                    self.handleSuccess(success, isPagination: isPagination)
                case .error(let errorCode, let error):
                    self.handleError(errorCode: errorCode, error: error)
                }
            }
        }
    }
    
    private func loadMoreDataIfNeeded(for index: Int) {
        if shouldLoadMoreData(for: index) {
            loadData(sort: output.currentSortType.value, isPagination: true)
        }
    }
    
    private func shouldLoadMoreData(for index: Int) -> Bool {
        return index >= output.shoppingItems.value.count - 3 && currentPage <= lastPage && !output.isAPILoading.value
    }

    
    private func handleSuccess(_ data: ShoppingResponse, isPagination: Bool) {
        let receivedItems = data.items
        
        lastPage = (data.total + itemsPerPage - 1) / itemsPerPage
        
        if isPagination {
            var updatedItems = output.shoppingItems.value
            updatedItems.append(contentsOf: receivedItems)
            output.shoppingItems.value = updatedItems
        } else {
            output.shoppingItems.value = receivedItems
            output.totalCount.value = data.total
            output.searchResultText.value = "\(data.total.formattedString) 개의 검색 결과"
        }
        
        if currentPage <= lastPage {
            currentPage += 1
        }
    }
    
    private func handleError(errorCode: Int, error: Error) {
        output.searchResultText.value = "검색 실패"
        output.errorMessage.value = "에러: \(error)\nErrorCode: \(errorCode)"
    }
}
