//
//  LottoUnitTests.swift
//  SeSAC7TestLectureUnitTests
//
//  Created by 서준일 on 10/16/25.
//

import XCTest
@testable import SeSAC7TestLecture

final class LottoUnitTests: XCTestCase {
    
    var sut: NetworkManager!

    override func setUpWithError() throws {
        sut = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // lotto response에서 보너스가 1~45에 해당하면 성공
    // UnitTest는 동기에 최적화 되어 있어서, 비동기 메서드를 기다리지 않는다.
    // 비동기를 기다려줄 수 있는 코드를 직접 작성을 해야 한다.
    // 1) expectation 2) wait 3) fulfill
    
    // 통신이 잘되는 환경에 대해서만 일관적인 결과를 준다.
    // 외부환경(네트워크 통신이 안되는 상황에서는 결과가 달라지고 클라이언트 코드 여부랑 상관이 없음) 영향을 받음
    // 네트워크 통신 상태와 무관한 상태로 테스트 코드를 작성하는 것이 중요 ! => Test Double
    // => DI, DIP
    func test_Lotto_BonusNumber_Valid() throws {
        
        print("1111")
        
        let promise = expectation(description: "로또 API CompletionHandler")
        
        sut.fetchLotto { value in
            
            print("2222")
            let min = 1
            let max = 45
            
            let number = value.bnusNo
            
            XCTAssertGreaterThanOrEqual(number, min)
            XCTAssertLessThanOrEqual(number, max)
            
            promise.fulfill()
        }
        
        print("3333")
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
