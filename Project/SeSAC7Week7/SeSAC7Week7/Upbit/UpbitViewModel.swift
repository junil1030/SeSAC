//
//  UpbitViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation
import Alamofire

final class UpbitViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        var viewDidLoadTrigger = ReviewObservable<Void>(())
        var cellSelectedTrigger = ReviewObservable<Upbit?>(nil)

    }
    
    struct Output {
        var marketData: ReviewObservable<[Upbit]> = ReviewObservable([])
        var navigationTitleData = ReviewObservable<String>("")
        var selectedTrigger = ReviewObservable<Upbit?>(nil)
    }
    
    init() {
        
        input = Input()
        output = Output()
        
        /*
         중복 호출을 방지하기 위해서는
         - lazyBind로 개선하거나,
         - bind를 쓰되, viewController, viewDidLoad에서 트리거를 주지 않거나
         */
        
        input.cellSelectedTrigger.bind {
            print("viewModel InputcellSelectedTrigger ", self.input.cellSelectedTrigger.value)
            let data = self.input.cellSelectedTrigger.value
            self.output.selectedTrigger.value = (data)
        }
        
        input.viewDidLoadTrigger.bind {
            print("viewModel InputViewDidLoadTrigger ", self.input.viewDidLoadTrigger.value)
            self.callRequest()
        }
    }
    
    func callRequest() {
        
        UpbitManager.shared.callRequest { [weak self] market, title in
            guard let self = self else { return }
            
            self.output.marketData.value = market
            self.output.navigationTitleData.value = title
        }
    }
    
}
