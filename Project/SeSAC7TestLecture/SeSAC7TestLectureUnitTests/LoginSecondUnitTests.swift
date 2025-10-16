//
//  LoginSecondUnitTests.swift
//  SeSAC7TestLectureUnitTests
//
//  Created by 서준일 on 10/16/25.
//

import XCTest
@testable import SeSAC7TestLecture

final class LoginSecondUnitTests: XCTestCase {
    
    var sut: Validator!
    
    let validUser = User(email: "junil@junil.com", password: "12345678", check: "123456")
    let invalidUser = User(email: "jun", password: "1234", check: "123456")

    override func setUpWithError() throws {
        sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_LoginViewController_ValidID_ReturnTrue() throws {
        let value = validUser.email
        let valid = sut.isValidID(email: value)
        XCTAssertTrue(valid)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
