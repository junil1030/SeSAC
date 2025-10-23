//
//  RenderingView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/23/25.
//

import SwiftUI
// State Property가 변경이 되면, body 프로퍼티를 다시 그림.
// State Property를 보여주고 있는 곳이 어느 곳도 없다면 렌더링 X
// State Property를 한군데라도 쓰고 있다면 body 렌더링 O
// init -> body. init은 되는데 body를 렌더링하지 않는다.
struct RenderingView: View {
    
    @State private var age = 0
    
    init() {
       print("RenderingView Init")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("다음 화면으로 넘어가기") {
                    Finn()
                }
                
                NavigationLink {
                    Finn()
                } label: {
                    Text("Hue: \(age)")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.random())
                }
                den
                bran()
                Finn()
                Button("클릭") {
                    print(age)
                    age = Int.random(in: 1...100)
                }
            }
            .navigationTitle("안녕")
        }
    }
    
    var den: some View {
        Text("Den")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
    }
    
    func bran() -> some View {
        Text("Bran")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
    }
}

private struct Finn: View {
    var body: some View {
        Text("Finn")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
    }
    
    init() {
        print("Finn Init")
    }
}

extension Color {
    static func random() -> Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

#Preview {
    RenderingView()
}
