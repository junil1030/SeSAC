//
//  ReviewNumberViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class ReviewNumberViewModel {
    
    var input: Input
    var output: Output
    
    // 뷰컨에서 뷰모델로 들어온 값
    struct Input {
        var amount = ReviewObservable<String?>(nil)
    }
    
    // 뷰모델에서 뷰컨으로 보여질 값
    struct Output {
        var amount = ReviewObservable<String>("")
    }
    
    init() {
        
        input = Input()
        output = Output()
        
        input.amount.bind {
            print("inputAmount 달라짐")
            
            //1.
            guard let text = self.input.amount.value else {
                self.output.amount.value = ""
                return
            }
            
            //2.
            if text.isEmpty {
                self.output.amount.value = "값을 입력해주세요"
                return
            }
            
            //3.
            guard let num = Int(text) else {
                self.output.amount.value = "숫자만 입력해주세요"
                return
            }
            
            //4.
            if num > 0, num <= 10000000 {
                   
                let format = NumberFormatter()
                format.numberStyle = .decimal
                let wonResult = format.string(from: num as NSNumber)!
                self.output.amount.value = "₩" + wonResult
                
                //                        let converted = Double(num) / exchangeRate
                //                        let convertedFormat = NumberFormatter()
                //                        convertedFormat.numberStyle = .currency
                //                        convertedFormat.currencyCode = "USD"
                //                        let convertedResult = convertedFormat.string(from: converted as NSNumber)
                //                        convertedAmountLabel.text = convertedResult
                
            } else {
                self.output.amount.value = "1,000만원 이하를 입력해주세요"
            }
        }
    }
}
