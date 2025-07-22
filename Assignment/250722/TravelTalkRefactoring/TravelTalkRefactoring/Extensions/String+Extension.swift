//
//  String+Extension.swift
//  TravelTalkRefactoring
//
//  Created by 서준일 on 7/22/25.
//

import Foundation

enum FormatCase: String {
    case yyMMdd = "yy.MM.dd"
    case hmma = "a h:mm"
    case yyyyMMdd = "yyyy년 MM월 dd일"
}

extension String {
    func dateFormatted(to format: FormatCase) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        inputFormatter.locale = Locale(identifier: "ko_KR")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format.rawValue
        outputFormatter.locale = Locale(identifier: "ko_KR")

        guard let date = inputFormatter.date(from: self) else {
            return self
        }

        let result = outputFormatter.string(from: date)

        if format == .hmma {
            let components = result.components(separatedBy: " ")
            if components.count == 2 {
                return "\(components[1]) \(components[0])"
            }
        }

        return result
    }
}
