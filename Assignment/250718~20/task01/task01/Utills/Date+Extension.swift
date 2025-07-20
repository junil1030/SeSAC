//
//  Date+Extension.swift
//  task01
//
//  Created by 서준일 on 7/20/25.
//

import Foundation

extension Date {
    func toStringFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}
