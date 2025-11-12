//
//  CoinViewModel_v3.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/11/25.
//

import Foundation
import Combine

final class CoinViewModel_v3: /*ViewModelType*/ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var input = Input()
    @Published var output = Output()
    
    init() {
        transform()
    }
}

extension CoinViewModel_v3 {
    
    struct Input {
        let viewOnTask = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var market: [Market] = []
    }
    
    enum Action {
        case viewOnTask
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewOnTask:
            input.viewOnTask.send(())
        }
    }
    
    private func transform() {
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
