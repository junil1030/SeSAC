//
//  NewTest.swift
//  SeSAC7TestLectureUnitTests
//
//  Created by 서준일 on 10/16/25.
//

/*
 접두어 test -> @Test
 동기 최적화(expec, wait, fulfill로 해결) -> Swift Concurrency(async await)로 가능
 XCTAssert -> #expect
 */
import Testing

struct NewTest {

    @Test func plus() async throws {
        
        let a = 2
        let b = 2
        
        let number = 4
        
        #expect(a + b == number)
        
        #expect(number >= 1 && number < 45)
    }

}
