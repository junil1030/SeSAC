//
//  LoginFirstUnitTests.swift
//  SeSAC7TestLectureUnitTests
//
//  Created by 서준일 on 10/16/25.
//

import XCTest
@testable import SeSAC7TestLecture

final class LoginFirstUnitTests: XCTestCase {
    
    // system under test: 이 시스템에서 테스트를 하려는 대상
    var sut: ViewController!

    override func setUpWithError() throws {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! ViewController
        
        sut = vc
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_LoginViewController_ValidID_ReturnTrue() throws {
        // Given
        let value = "junil@junil.com"
        // When
        sut.idField.text = value
        // Then
        XCTAssertTrue(sut.isValidID(), "@가 없거나 6글자 미만임")
    }

    // 실패 케이스를 할 때에도 테스트 결과는 성공으로 나와야 함
    func test_LoginViewController_ValidID_returnFalse() throws {
        // Given
        let value = "jun@"
        // When
        sut.idField.text = value
        // Then
        XCTAssertFalse(sut.isValidID(), "@가 없거나 6글자 미만임")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
