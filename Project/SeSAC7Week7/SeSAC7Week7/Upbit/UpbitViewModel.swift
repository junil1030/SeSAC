//
//  UpbitViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation
import Alamofire

final class UpbitViewModel {
    
    var inputViewDidLoadTrigger = ReviewObservable<Void>(())
    var inputCellSelectedTrigger = ReviewObservable<Upbit?>(nil)
    
    var outputMarketData: ReviewObservable<[Upbit]> = ReviewObservable([])
    var outputNavigationTitleData = ReviewObservable<String>("")
    var outputSelectedTrigger = ReviewObservable<Upbit?>(nil)
    
    init() {
        /*
         중복 호출을 방지하기 위해서는
         - lazyBind로 개선하거나,
         - bind를 쓰되, viewController, viewDidLoad에서 트리거를 주지 않거나
         */
        
        inputCellSelectedTrigger.bind {
            print("viewModel InputcellSelectedTrigger ", self.inputCellSelectedTrigger.value)
            let data = self.inputCellSelectedTrigger.value
            self.outputSelectedTrigger.value = (data)
        }
        
        inputViewDidLoadTrigger.bind {
            print("viewModel InputViewDidLoadTrigger ", self.inputViewDidLoadTrigger.value)
            self.callRequest()
        }
    }
    
    func callRequest() {
        
        UpbitManager.shared.callRequest { [weak self] market, title in
            guard let self = self else { return }
            
            self.outputMarketData.value = market
            self.outputNavigationTitleData.value = title
        }
    }
    
}
