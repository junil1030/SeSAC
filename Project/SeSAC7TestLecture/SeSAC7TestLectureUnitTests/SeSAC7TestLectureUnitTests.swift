//
//  SeSAC7TestLectureUnitTests.swift
//  SeSAC7TestLectureUnitTests
//
//  Created by 서준일 on 10/16/25.
//

import XCTest
@testable import SeSAC7TestLecture

final class SeSAC7TestLectureUnitTests: XCTestCase {
    
    var number: Int?

    override func setUpWithError() throws {
        print(#function)
    }

    override func tearDownWithError() throws {
        print(#function)
    }

    // setUpWithError -> testExample -> tearDownWithError
    func testPlus() throws {
        print(#function)
        
        let a = 2
        let b = 2
        
        number = 4
        
        XCTAssertEqual(a + b, number, "덧셈 결과가 같지 않음")
    }
    
    func testMinus() throws {
        print(#function)
        
        let a = 2
        let b = 2
        
        number = 0
        
        XCTAssertEqual(a - b, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
