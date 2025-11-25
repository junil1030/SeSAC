//
//  IAPViewController.swift
//  SeSAC7ConcurrencyIssue
//
//  Created by 서준일 on 11/25/25.
//

import UIKit
import StoreKit

class IAPViewController: UIViewController {
    
    let productIdentifier: Set<Product.ID> = [
        "com.junil.concurrencyIssue.cookie10",
        "com.junil.concurrencyIssue.cookie3month",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        print(#function)
        Task {
            await loadProductData()
        }
    }
    
    func loadProductData() async {
        print(#function)
        do {
            let product = try await Product.products(for: productIdentifier)
            
            for item in product {
                dump(item)
            }
        } catch {
            print("인앱 상품 로드 실패: \(error)")
        }
    }

    func purchaseProduct(_ product: Product) async {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verificationResult):
                print(verificationResult) // 서버 영수증 검증
            case .userCancelled: // 유저 취소
            case .pending: // 펜딩
            @unknown default:
                <#fatalError()#>
            }
        } catch {
            print("구매 실패, 카드 유효기간 만료. 중간에 이탈, 잔액부족 등")
        }
    }
}
