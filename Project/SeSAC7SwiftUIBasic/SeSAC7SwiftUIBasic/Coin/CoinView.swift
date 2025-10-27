//
//  CoinView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/27/25.
//

import SwiftUI

struct Money: Identifiable {
    let id = UUID()
    let name: String
    let count: Int
    var like: Bool
}

struct CoinView: View {
    
    @State private var list: [Money] = [
        Money(name: "비트코인", count: 123, like: false),
        Money(name: "이더리움", count: 123, like: false),
        Money(name: "도지코인", count: 123, like: false),
    ]

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                listView()
            }
            .navigationTitle("My Coin")
        }
        .onAppear { // .onAppear vs .task(iOS 15+)
            list = [
                Money(name: "비트코인", count: 123, like: false),
                Money(name: "이더리움", count: 123, like: false),
                Money(name: "도지코인", count: 123, like: false),
            ]
        }
    }
    
    func listView() -> some View {
        LazyVStack {
            ForEach($list) { item in
                CoinRowView(data: item)
            }
        }
    }
}

#Preview {
    CoinView()
}
