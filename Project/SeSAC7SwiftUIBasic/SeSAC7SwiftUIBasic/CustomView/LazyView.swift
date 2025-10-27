//
//  LazyView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/27/25.
//

import SwiftUI

struct LazyView<Content: View>: View {
    
    private let content: () -> Content
    
    var body: some View {
        content()
    }
    
    init(content: @autoclosure @escaping () -> Content) {
        self.content = content
    }
}

struct TestView: View {
    var body: some View {
        LazyView(content: Text("asdf"))
    }
}

#Preview {
    LazyView(content: Text("Test"))
}
