//
//  BasicView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/20/25.
//

import SwiftUI

struct BasicView: View {
    var body: some View {
        ProfileView()
        ProfileView()
        ProfileView()
        Image(systemName: "star.fill")
            .asYellowBackGroundCornerView(50)
        
        Text("Hello, World!")
            .padding()
            .border(.black, width: 3)
            .background(.yellow)
            .padding()
            .border(.red)
        
        Text("Hello, World!")
            .border(.black, width: 3)
            .background(.yellow)
            .padding()
            .background(.red)
    }
}

#Preview {
    BasicView()
}
