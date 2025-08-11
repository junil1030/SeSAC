//
//  LoginViewModel.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/11/25.
//

import Foundation

class LoginViewModel {
    
    var inputIdTextFieldText = Field("")
    var outputValidationLabel = Field("")
    var outputTextColor = Field(false)
    
    init() {
        print("LoginViewModel Init")
        
        inputIdTextFieldText.playAction { _ in
            self.validation()
        }
    }
    
    private func validation() {
        if inputIdTextFieldText.value.count < 4 {
            outputValidationLabel.value = "4자리 미만입니다"
            outputTextColor.value = false
        } else {
            outputValidationLabel.value = "잘 했어요"
            outputTextColor.value = true
        }
    }
}
