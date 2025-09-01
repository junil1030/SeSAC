//
//  ResultViewModel.swift
//  task01
//
//  Created by 서준일 on 8/12/25.
//

import Foundation
import RxSwift
import RxCocoa

class ResultViewModel {
    
    //MARK: - Properties
    private let searchKeyword: String
    private var currentSortType = SortType.sim
    private let itemsPerPage = 30
    private var currentPage = 1
    private var lastPage = 1
    private var totalCount = 0
    private var allItems: [ShoppingItem] = []
    
    //MARK: - Observables Streams
    struct Input {
        let sortButtonClicked: Observable<SortType>
        let loadMoreData: Observable<Void>
    }
    
    struct Output {
        let items: Driver<[ShoppingItem]>
        let itemCount: Driver<Int>
        let showErrorAlert: Driver<String>
        let title: Driver<String>
    }
    
    //MARK: - Initialize
    init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
    }
    
    //MARK: - Transform
    func transforom(input: Input) -> Output {
        
        let sortChange = input.sortButtonClicked
            .distinctUntilChanged()
            .withUnretained(self)
            .flatMapLatest { owner, sortType in
                
                owner.currentSortType = sortType
                owner.currentPage = 1
                owner.allItems = []
                
                return CustomObservable.fetchItems(with: owner.searchKeyword, sort: owner.currentSortType, start: owner.currentPage)
            }
            .share()
          
        let loadMore = input.loadMoreData
            .withUnretained(self)
            .filter { owner, _ in
                return owner.currentPage <= owner.lastPage
            }
            .flatMapLatest { owner, _ in
                return CustomObservable.fetchItems(with: owner.searchKeyword, sort: owner.currentSortType, start: owner.currentPage)
            }
            .share()
        
        let allResponse = Observable.merge(sortChange, loadMore)
        
        let successResponse = allResponse
            .withUnretained(self)
            .compactMap { (owner, response) -> ShoppingResponse? in
                switch response {
                case .success(let value):
                    owner.updatePagination(with: value)
                    return value
                case .failure:
                    return nil
                }
            }
            .share()
        
        let items = successResponse
            .withUnretained(self)
            .map { owner, _ in owner.allItems }
            .asDriver(onErrorJustReturn: [])
        
        let itemCount = successResponse
            .withUnretained(self)
            .map { owner, _ in owner.totalCount }
            .asDriver(onErrorJustReturn: 0)
        
        let showErrorAlert = allResponse
            .compactMap { response -> String? in
                switch response {
                case .success(let value):
                    return value.items.isEmpty ? "검색 결과가 없습니다" : nil
                case .failure(let error):
                    return error.localizedDescription
                }
            }
            .asDriver(onErrorJustReturn: "알 수 없는 오류")
        
        let title = successResponse
            .withUnretained(self)
            .map { owner, _ in owner.searchKeyword}
            .asDriver(onErrorJustReturn: "")
        
        return Output(
            items: items,
            itemCount: itemCount,
            showErrorAlert: showErrorAlert,
            title: title
        )
    }
    
    //MARK: - Private Methods
    private func updatePagination(with response: ShoppingResponse) {
        totalCount = response.total
        currentPage = response.start
        lastPage = (totalCount + itemsPerPage - 1) / itemsPerPage
        
        if currentPage == 1 {
            allItems = response.items
        } else {
            allItems.append(contentsOf: response.items)
        }
        
        currentPage += 1
    }
}
