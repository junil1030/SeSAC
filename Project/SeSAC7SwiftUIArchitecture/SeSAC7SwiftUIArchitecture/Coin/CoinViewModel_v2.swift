//
//  CoinViewModel_v2.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/11/25.
//

import Foundation
import Combine

final class CoinViewModel_v2: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    
    @Published
    var output = Output()
    
    struct Input {
        let viewOnTask = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var market: [Market] = []
    }
    
    init() {
        input.viewOnTask
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.fetchMarket()
                
            }
            .store(in: &cancellables)
    }
    
    private func fetchMarket() {
        UpbitAPI.fetchAllMarket { [weak self] data in
            guard let self = self else  { return }
            self.output.market = data
        }
    }
    
}
