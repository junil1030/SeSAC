//
//  NumberViewModel.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/8/25.
//

import Foundation

class NumberViewModel {
    
    // VC에서 VM으로 들어오는 정보
    var inputFiled = Field("")
    
    // VM에서 VC로 보내줄 정보
    var outputText = Field("")
    
    init() {
        print("NumberViewModel Init")
        
        inputFiled.playAction {_ in 
            self.validate()
        }
    }
    
    var outputColor = false
    
    private func validate() {
//        //1) 옵셔널
//        guard let text = inputField else {
//            outputText = ""
//            outputColor = false
//            return
//        }
        
        let text = inputFiled.value
        
        //2) Empty
        if text.isEmpty {
            outputText.value = "값을 입력해주세요"
            outputColor = false
            return
        }
        
        //3) 숫자 여부
        guard let num = Int(text) else {
            outputText.value = "숫자만 입력해주세요"
            outputColor = false
            return
        }
        
        //4) 0 - 1,000,000
        if num > 0, num <= 1000000 {
            
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)!
            outputText.value = "₩" + result
            outputColor = true
        } else {
            outputText.value = "백만원 이하를 입력해주세요"
            outputColor = false
        }
    }
}
