//
//  String+Enxtension.swift
//  task01
//
//  Created by 서준일 on 7/23/25.
//

import Foundation

extension String {
    func dateFormatted() -> String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyyMMdd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: self) else {
            return self
        }
        
        return outputFormatter.string(from: date)
    }
}
