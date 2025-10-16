//
//  LoginViewControllerUITests.swift
//  SeSAC7TestLectureUITests
//
//  Created by 서준일 on 10/15/25.
//

import XCTest

final class LoginViewControllerUITests: XCTestCase {

    // 테스트 전에 실행되는 메서드
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    // 테스트 이후에 다른 조건들이 변경되지 않도록, 테스트 후에 초기화 하는 메서드
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginViewControllerLoginSucceed() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["login_id_field"].tap()
        app.textFields["login_id_field"].typeText("junil@jun.com")
        
        app.textFields["login_pw_field"].tap()
        app.textFields["login_pw_field"].typeText("12345678")
        
        app.textFields["login_btn_signin"].tap()
        
        XCTAssertTrue(app.staticTexts["로그인 성공"].exists)
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
