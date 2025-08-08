//
//  NumberViewModel.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/8/25.
//

import Foundation

class NumberViewModel {
    
    // VC에서 VM으로 들어오는 정보
    var inputField: String? {
        didSet {
            validate()
        }
    }
    
    // VM에서 VC로 보내줄 정보
    var outputText = "" {
        didSet {
            onChangeText?()
        }
    }
    var outputColor = false
    
    var onChangeText: (() -> Void)?
    
    private func validate() {
        //1) 옵셔널
        guard let text = inputField else {
            outputText = ""
            outputColor = false
            return
        }
        
        //2) Empty
        if text.isEmpty {
            outputText = "값을 입력해주세요"
            outputColor = false
            return
        }
        
        //3) 숫자 여부
        guard let num = Int(text) else {
            outputText = "숫자만 입력해주세요"
            outputColor = false
            return
        }
        
        //4) 0 - 1,000,000
        if num > 0, num <= 1000000 {
            
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)!
            outputText = "₩" + result
            outputColor = true
        } else {
            outputText = "백만원 이하를 입력해주세요"
            outputColor = false
        }
    }
}
