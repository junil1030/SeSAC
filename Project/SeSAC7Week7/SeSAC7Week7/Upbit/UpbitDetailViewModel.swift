//
//  UpbitDetailViewModel.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/12/25.
//

import Foundation

final class UpbitDetailViewModel {
    
    var outputTitle = ReviewObservable<String?>(nil)
    
    init() {
        print("UpbitDetailViewModel Init")
        print(outputTitle.value)
        
        outputTitle.bind {
            print("outputTitle bind ", self.outputTitle.value)
        }
    }
}
