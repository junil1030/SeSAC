//
//  TamagotchiView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/23/25.
//

import SwiftUI

struct TamagotchiView: View {
    
    @State private var rice = 0
    @State private var water = 0
    
    @State private var text = ""
    
    var body: some View {
        Text("밥알 \(rice)개, 물방울 \(water)개")
            .font(.title)
        
        TextField("밥알을 입력해주세요", text: $text)
        RiceButtonView(rice: $rice)
        
        Button("물방울 먹이기") {
            print("물방울 클릭")
            if let value = Int(text) {
                water += value
            } else {
                water += 1
            }
        }
        .font(.title)
    }
}
/*
 상위뷰의 SOT를 참조받음
 값을 수정하게 되면 상위뷰의 State에 전달
 */
struct RiceButtonView: View {
    
    @Binding var rice: Int // Derived Value
    
    var body: some View {
        Button("밥알 먹이기") {
            print("밥알 클릭")
            rice += 1
        }
        .font(.title)
    }
}

#Preview {
    TamagotchiView()
}
