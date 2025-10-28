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
//        Money(name: "이더리움", count: 123, like: false),
//        Money(name: "도지코인", count: 123, like: false),
    ]

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                bannerView()
                listView()
            }
            .navigationTitle("My Coin")
        }
        .onAppear { // .onAppear vs .task(iOS 15+)
//            Task {
//                list = [
//                    Money(name: "비트코인", count: 123, like: false),
//                    Money(name: "이더리움", count: 123, like: false),
//                    Money(name: "도지코인", count: 123, like: false),
//                ]
//            }
        }
        .task {
            list = [
                Money(name: "비트코인", count: 123, like: false),
                Money(name: "이더리움", count: 123, like: false),
                Money(name: "도지코인", count: 123, like: false),
            ]
        }
    }
    
    func bannerView() -> some View {
        ZStack {
            Rectangle()
                .fill(.brown) // fill vs background
                .overlay {
                    Circle()
                        .fill(.white.opacity(0.3))
                        .scaleEffect(2, anchor: .trailing)
                        .offset(x: -50)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                    .font(.callout)
                Text("2,000,000,000원")
                    .font(.title)
                    .bold()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .frame(height: 160)
    }
    
    func listView() -> some View {
        LazyVStack {
            ForEach($list) { item in
                CoinRowView(data: item)
            }
        }
    }
    
    func listViewLet() -> some View {
        LazyVStack {
            ForEach(list) { item in
                CoinRowLetView(data: item)
            }
        }
    }
}

#Preview {
    CoinView()
}
