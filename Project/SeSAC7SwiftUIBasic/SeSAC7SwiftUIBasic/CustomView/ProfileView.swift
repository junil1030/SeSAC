//
//  ProfileView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/20/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        HStack {
                    Text("Jack")
                        .asYellowBackGroundCornerView()
                    Text("Finn")
                        .asYellowBackGroundCornerView(30)
                    Text("Den")
                        .asYellowBackGroundCornerView(60)
                }
    }
}

#Preview {
    ProfileView()
}
