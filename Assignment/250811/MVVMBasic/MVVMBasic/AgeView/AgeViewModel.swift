//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by 서준일 on 8/8/25.
//

import Foundation

class AgeViewModel: ValidateProtocol {
    
//    var onValidationSuccess: ((Int) -> Void)?
//    var onValidationFailure: ((String) -> Void)?
    
    var validationResult = Observable<String>("여기에 결과를 보여주세요")
    
    func validateAge(text: String?) {
        let result = validateUserData(text, min: 1, max: 100)
        
        switch result {
        case .success(let age):
//            onValidationSuccess?(age)
            validationResult.value = "\(age)"
        case .failure(let error):
//            onValidationFailure?(error.message)
            validationResult.value = error.message
        }
    }
    
}
