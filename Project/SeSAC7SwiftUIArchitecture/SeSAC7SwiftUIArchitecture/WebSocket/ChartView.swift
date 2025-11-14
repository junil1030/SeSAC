//
//  ChartView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/12/25.
//

import SwiftUI

struct ChartView: View {
    
    @StateObject var viewModel = ChartViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button("소켓 연결 시작") {
                        WebsocketManager.shared.openWebSocket()
                        
                        WebsocketManager.shared.sendMessgae(
                  """
                  [{"ticket":"test"},{"type":"orderbook","codes":["KRW-BTC"]}]
                  """
                        )
                    }
                    
                    Button("소켓 연결 끝") {
                        WebsocketManager.shared.closeWebSocket()
                    }
                }
                ForEach(viewModel.askOrderBook) { item in
                    Text(item.price.formatted())
                }
                .background(Color.red.opacity(0.2))
                
                ForEach(viewModel.bidOrderBook) { item in
                    Text(item.price.formatted())
                }
                .background(Color.blue.opacity(0.2))
            }
        }
    }
}

#Preview {
    ChartView()
}
