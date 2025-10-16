//
//  LottoNetworkUnitTests.swift
//  SeSAC7TestLectureUnitTests
//
//  Created by 서준일 on 10/16/25.
//

import XCTest
@testable import SeSAC7TestLecture

final class LottoNetworkUnitTests: XCTestCase {
    
    var sut: LottoViewModel!
    
    let succeedLotto = Lotto(drwNoDate: "2025-10-15", bnusNo: 34, drwtNo1: 1)

    override func setUpWithError() throws {
        
        let manager = MockManager()
        manager.mock = succeedLotto
        
        sut = LottoViewModel(networkManager: manager)
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        
        let expectation = XCTestExpectation(description: "Lotto Mock Test")
        
//        sut.transform {
//            expectation.fulfill()
//        }
//        
//        wait(for: [], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
