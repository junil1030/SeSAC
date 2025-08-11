//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by 서준일 on 8/10/25.
//

import Foundation

class WordCounterViewModel {
    
//    var onCountUpdated: ((String) -> Void)?
    var countResultText = Observable<String>("현재까지 0글자 작성중")
    
    func updateText(_ text: String) {
        let currentCount = text.count
        let countText = formatCountText(currentCount)
        
//        onCountUpdated?(countText)
        countResultText.value = countText
    }
    
    private func formatCountText(_ count: Int) -> String {
        return "현재까지 \(count)글자 작성중"
    }
}
