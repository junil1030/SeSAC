//
//  CoinNetworkView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/29/25.
//

import SwiftUI

struct CoinNetworkView: View {
    
    @State private var list: [Market] = [Market(market: "a", koreanName: "aa", englishName: "asdf")]

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                listView()
            }
            .navigationTitle(
                "\(UserDefaults.standard.string(forKey: "coin") ?? "없음")"
            )
        }
        .onAppear {
            Task {
                do {
                    let result = try await Network.fetchAllMarket()
                    list = result
                } catch APIError.invalidResponse {
                    list = []
                } catch {
                    print("에러 발생")
                }
            }
        }
        .onDisappear {}
        .task {
            
        }
    }
    
    func listView() -> some View {
        LazyVStack {
            ForEach(list) { item in
                CoinNetworkRow(data: item)
                    .buttonWrapper {
                        UserDefaults.standard.set(item.koreanName, forKey: "coin")
                    }
            }
        }
    }
}

struct CoinNetworkRow: View {
    
    let data: Market
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.market)
                    .fontWeight(.bold)
                Text(data.koreanName)
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text("BTC-KRW")
            Image(systemName: data.like ? "star.fill" : "star")
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 6)
    }
}

// 실제 네트워크 통신이 Preview에서도 발생
// 프리뷰를 쓰지말던가.. 프리뷰에서만 목업 데이터를 쓰던가..
// iOS18+에서는 @Previewalble, PreviewModifier가 등장

#Preview {
    CoinNetworkView()
}
