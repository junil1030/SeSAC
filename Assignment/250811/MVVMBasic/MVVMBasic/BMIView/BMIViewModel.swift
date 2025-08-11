//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by 서준일 on 8/8/25.
//

import Foundation

class BMIViewModel: ValidateProtocol {
    
//    var onCalculationSuccess: ((Double) -> Void)?
//    var onCalculationFailure: ((String) -> Void)?
    
    var calculationResult = Observable<Result<String, Error>?>(nil)
    
    func validateBMI(height: String?, weight: String?) {
        
        let heightResult = validateUserData(height, min: 0.5, max: 2.5)
        guard case .success(let heightValue) = heightResult else {
            if case .failure(let failure) = heightResult {
//                onCalculationFailure?(failure.message)
                calculationResult.value = .failure(failure)
            }
            return
        }
        
        let weightResult = validateUserData(weight, min: 10.0, max: 200.0)
        guard case .success(let weightValue) = weightResult else {
            if case .failure(let failure) = weightResult {
//                onCalculationFailure?(failure.message)
                calculationResult.value = .failure(failure)
            }
            return
        }
        
        let result = calculateBMI(height: heightValue, weight: weightValue)
//        onCalculationSuccess?(result)
        calculationResult.value = .success("\(result)")
    }
    
    private func calculateBMI(height: Double, weight: Double) -> Double {
        return weight / pow(height, 2)
    }
}
