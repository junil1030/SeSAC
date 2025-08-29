//
//  String+Extension.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
//

import Foundation

extension String {
    
    var cleanText: String {
        let removeHTMLTags = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return removeHTMLTags.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var formattedString: String {
        guard let number = Int(self) else { return self }
        return number.formattedString
    }
    
    var wonString: String {
        guard let number = Int(self) else { return self + "원" }
        return number.wonString
    }

}
