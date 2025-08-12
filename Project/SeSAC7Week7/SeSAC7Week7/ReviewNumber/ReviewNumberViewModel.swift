//
//  ReviewNumberViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class ReviewNumberViewModel {
    
    var inputAmount = ReviewObservable<String?>(nil)
    var outputAmount = ReviewObservable<String>("")
    
    init() {
        inputAmount.bind {
            print("inputAmount 달라짐")
            
            //1.
            guard let text = self.inputAmount.value else {
                self.outputAmount.value = ""
                return
            }
            
            //2.
            if text.isEmpty {
                self.outputAmount.value = "값을 입력해주세요"
                return
            }
            
            //3.
            guard let num = Int(text) else {
                self.outputAmount.value = "숫자만 입력해주세요"
                return
            }
            
            //4.
            if num > 0, num <= 10000000 {
                   
                let format = NumberFormatter()
                format.numberStyle = .decimal
                let wonResult = format.string(from: num as NSNumber)!
                self.outputAmount.value = "₩" + wonResult
                
                //                        let converted = Double(num) / exchangeRate
                //                        let convertedFormat = NumberFormatter()
                //                        convertedFormat.numberStyle = .currency
                //                        convertedFormat.currencyCode = "USD"
                //                        let convertedResult = convertedFormat.string(from: converted as NSNumber)
                //                        convertedAmountLabel.text = convertedResult
                
            } else {
                self.outputAmount.value = "1,000만원 이하를 입력해주세요"
            }
        }
    }
}
