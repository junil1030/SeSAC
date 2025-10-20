//
//  ContentView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/20/25.
//

import SwiftUI

struct User {
    var nickname = "고래밥"
    
    var introduce: String {
        mutating get {
            nickname = "칙촉"
            return "안녕하세요 저는 \(nickname)입니다."
        }
    }
    
    mutating func changeNickname() {
        nickname = "칙촉"
        print("안녕하세요 저는 \(nickname)입니다.")
    }
    
    // 제네릭은 선언할 때 타입을 모름.
    // 사용할 때 타입이 정해짐
    func abc<T: Numeric>(a: T) {
        print(a)
    }
}

struct ContentView: View {
    
    let user = User()
    
    var nickname = "고래밥"
    
    var body: some View {
        Text(nickname)
        Button("닉네임 변경") {
//            let value = type(of: self.body)
//            print(value)
//            nickname = "칙촉"
        }
        .foregroundStyle(.red)
    }
}

#Preview {
    ContentView()
}
