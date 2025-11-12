//
//  CoinViewModel.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/11/25.
//

import Foundation
import Combine

final class CoinViewModel: ObservableObject {
    
    @Published var market: [Market] = []
 
    func fetchMarket() {
        UpbitAPI.fetchAllMarket { data in
            self.market = data
        }
    }
}
