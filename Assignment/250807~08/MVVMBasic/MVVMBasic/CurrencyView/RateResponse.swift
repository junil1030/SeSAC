//
//  RateResponseModel.swift
//  MVVMBasic
//
//  Created by 서준일 on 8/10/25.
//

import Foundation


struct Welcome: Codable {
    let pkid, count: Int
    let country: [Country]
    let calculatorMessage: String
}

struct Country: Codable {
    let value, subValue, currencyUnit: String
}
