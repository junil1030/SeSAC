//
//  BirthDayViewModel.swift
//  MVVMBasic
//
//  Created by 서준일 on 8/8/25.
//

import Foundation

class BirthDayViewModel: ValidateProtocol {
    
    private enum DateError: Error {
        case invalidDate
        
        var message: String {
            return "존재하지 않는 날짜입니다."
        }
    }
    
    var onCalculationSuccess: ((String) -> Void)?
    var onCalculationFailure: ((String) -> Void)?
    
    func validateBirthDay(year: String?, month: String?, day: String?) {
        
        let yearResult = validateUserData(year, min: 0, max: 9999)
        guard case .success(let yearValue) = yearResult else {
            if case .failure(let failure) = yearResult {
                onCalculationFailure?(failure.message)
            }
            return
        }
        
        let monthResult = validateUserData(month, min: 1, max: 12)
        guard case .success(let monthValue) = monthResult else {
            if case .failure(let failure) = monthResult {
                onCalculationFailure?(failure.message)
            }
            return
        }
        
        let dayResult = validateUserData(day, min: 1, max: 31)
        guard case .success(let dayValue) = dayResult else {
            if case .failure(let failure) = dayResult {
                onCalculationFailure?(failure.message)
            }
            return
        }
        
        guard let dDay = calculateDday(year: yearValue, month: monthValue, day: dayValue) else {
            onCalculationFailure?(DateError.invalidDate.message)
            return
        }
        
        let resultText = formatResult(dDay)
        onCalculationSuccess?(resultText)
    }
    
    private func formatResult(_ dDay: Int) -> String {
        if dDay > 0 {
            return "D-\(dDay)"
        } else if dDay == 0 {
            return "D-Day"
        } else {
            return "D+\(abs(dDay))"
        }
    }
    
    private func calculateDday(year: Int, month: Int, day: Int) -> Int? {
        let today = Date()
        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        guard let targetDate = calendar.date(from: dateComponents) else {
            return nil
        }
        
        let todayWithOutTime = calendar.startOfDay(for: today)
        let targetDayWithOutTime = calendar.startOfDay(for: targetDate)
        
        let component = calendar.dateComponents([.day], from: todayWithOutTime, to: targetDayWithOutTime)
        
        return component.day
    }

}
