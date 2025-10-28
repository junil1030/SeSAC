//
//  CoinRowView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/27/25.
//

import SwiftUI

struct CoinRowView: View {
    
    @Binding var data: Money
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.name)
                    .fontWeight(.bold)
                Text(data.count.formatted())
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text("BTC-KRW")
            Image(systemName: data.like ? "star.fill" : "star")
                .buttonWrapper {
                    data.like.toggle()
                }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 6)
    }
}

struct CoinRowLetView: View {
    
    let data: Money
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.name)
                    .fontWeight(.bold)
                Text(data.count.formatted())
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

#Preview {
    CoinRowView(data: .constant(Money(name: "비트코인", count: 123, like: true)))
}
