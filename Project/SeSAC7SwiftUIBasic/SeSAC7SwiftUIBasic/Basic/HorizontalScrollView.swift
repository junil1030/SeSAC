//
//  HorizontalScrollView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/21/25.
//

import SwiftUI

struct HorizontalScrollView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<100) {
                    Text("\($0)")
                }
            }
        }
    }
}

#Preview {
    HorizontalScrollView()
}
