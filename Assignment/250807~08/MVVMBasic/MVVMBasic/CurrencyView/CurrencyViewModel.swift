//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 서준일 on 8/10/25.
//

import Foundation

class CurrencyViewModel {
    
    private var currentExchangeRate: Double = 1350.0
    
    var onExchangeRateUpdated: ((String) -> Void)?
    var onConversionResult: ((String) -> Void)?
    var onError: ((String) -> Void)?
    
    init() {
        fetchExchangeRate()
    }
    
    func convertCurrency(_ amountText: String?) {
        guard let amountText = amountText,
              !amountText.isEmpty else {
            onError?("금액을 입력해주세요")
            return
        }
        
        let cleanText = amountText.replacingOccurrences(of: ",", with: "")
        
        guard let amount = Double(cleanText) else {
            onError?("올바른 금액을 입력해주세요")
            return
        }
        
        guard amount > 0 else {
            onError?("0보다 큰 금액을 입력해주세요")
            return
        }
        
        // 환전 계산
        let convertedAmount = amount / currentExchangeRate
        let resultText = formatConversionResult(krw: amount, usd: convertedAmount)
        
        onConversionResult?(resultText)
    }
    
    func refreshExchangeRate() {
        fetchExchangeRate()
    }
    
    private func fetchExchangeRate() {
        guard let url = URL(string: "https://m.search.naver.com/p/csearch/content/qapirender.nhn?key=calculator&pkid=141&q=환율&where=m&u1=keb&u6=standardUnit&u7=0&u3=USD&u4=KRW&u8=down&u2=1") else {
            updateExchangeRateDisplay()
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("네트워크 에러: \(error)")
                DispatchQueue.main.async {
                    self.updateExchangeRateDisplay()
                }
                return
            }
            
            guard let data = data else {
                print("데이터가 없습니다")
                DispatchQueue.main.async {
                    self.updateExchangeRateDisplay()
                }
                return
            }
            
            do {
                let rateResponse = try JSONDecoder().decode(RateResponse.self, from: data)
                
                if let wonCurrency = rateResponse.country.first(where: { $0.currencyUnit == "원" }) {
                    let rateString = wonCurrency.value.replacingOccurrences(of: ",", with: "")
                    if let rate = Double(rateString) {
                        DispatchQueue.main.async {
                            self.currentExchangeRate = rate
                            self.updateExchangeRateDisplay()
                        }
                    }
                }
                
            } catch {
                print("JSON 파싱 에러: \(error)")
                DispatchQueue.main.async {
                    self.updateExchangeRateDisplay()
                }
            }
            
        }.resume()
    }
    
    private func updateExchangeRateDisplay() {
        let formattedRate = formatExchangeRate(currentExchangeRate)
        let rateText = "현재 환율: 1 USD = \(formattedRate) KRW"
        onExchangeRateUpdated?(rateText)
    }
    
    private func formatExchangeRate(_ rate: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: rate)) ?? "\(rate)"
    }
    
    private func formatConversionResult(krw: Double, usd: Double) -> String {
        let krwFormatter = NumberFormatter()
        krwFormatter.numberStyle = .decimal
        krwFormatter.maximumFractionDigits = 0
        
        let usdFormatter = NumberFormatter()
        usdFormatter.numberStyle = .decimal
        usdFormatter.minimumFractionDigits = 2
        usdFormatter.maximumFractionDigits = 2
        
        let krwFormatted = krwFormatter.string(from: NSNumber(value: krw)) ?? "\(Int(krw))"
        let usdFormatted = usdFormatter.string(from: NSNumber(value: usd)) ?? String(format: "%.2f", usd)
        
        return "\(krwFormatted)원 = $\(usdFormatted)"
    }
}
