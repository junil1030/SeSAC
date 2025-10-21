//
//  RenderView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/21/25.
//

import SwiftUI

/* Property, Method, Struct */
struct RenderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            JunilView()
            Text("jack")
                .font(.largeTitle)
                .background(.yellow)
                .foregroundStyle(.blue)
            Text("Finn")
                .font(.largeTitle)
                .background(.yellow)
                .foregroundStyle(.blue)
            Text("Den")
                .font(.largeTitle)
                .background(.yellow)
                .foregroundStyle(.blue)
            Text("Hue").font(.largeTitle)
                .background(.yellow)
                .foregroundStyle(.blue)
            Text("Bran").font(.largeTitle)
                .background(.yellow)
                .foregroundStyle(.blue)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .background(.red)
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
