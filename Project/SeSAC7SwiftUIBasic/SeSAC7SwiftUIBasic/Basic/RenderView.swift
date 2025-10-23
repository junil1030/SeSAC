//
//  RenderView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/21/25.
//

import SwiftUI

/* Property, Method, Struct */
struct RenderView: View {
    
    @State private var text = "Juiil"
    @State private var nickname = "고래밥"
    
    var body: some View {
        VStack {
            TextField("닉네임을 입력해보세요", text: $text)
            NicknameView(nickname: $nickname)
                .background(.yellow)
            Text("닉네임 추천: \(nickname)")
                .background(.gray)
        }
        JunilView()
    }
    
    func finnView() -> some View {
        Text("Finn")
            .font(.largeTitle)
            .background(.yellow)
            .foregroundStyle(.blue)
    }
    var denView: some View {
        Text("Den")
            .font(.largeTitle)
            .background(.yellow)
            .foregroundStyle(.blue)
    }
}

struct NicknameView: View {
    @Binding var nickname: String
    
    var body: some View {
        HStack {
            Text("닉네임 추천: \(nickname)")
            Button("추천받기") {
                nickname = "카스타드 \(Int.random(in: 1...1000))"
            }
        }
    }
}

struct JunilView: View {
    var body: some View {
        Text("JunilJunilJunilJunil")
            .font(.largeTitle)
            .background(.yellow)
            .foregroundStyle(.blue)
    }
}

#Preview {
    RenderView()
}
