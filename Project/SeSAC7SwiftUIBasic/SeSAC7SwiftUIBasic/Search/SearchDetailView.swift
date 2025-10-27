//
//  SearchDetailView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/27/25.
//

import SwiftUI

struct SearchDummyView: View {
    var body: some View {
        SearchDetailView(data: Person(name: "테스트", age: 99))
    }
    
    init() {
        print("Search Dummy View")
    }
}

struct SearchDetailView: View {
    
    let data: Person
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.fill")
            HStack {
                Text(data.name)
                Text("\(data.age)세")
            }
            
            NavigationLink("다음 화면 전환하기") {
                SearchDetailInfoView()
            }
        }
    }
    
    init(data: Person) {
        self.data = data
        print("SearchDetailView Init \(data.name)")
    }
}

private struct SearchDetailInfoView: View {
    var body: some View {
        Text("상세 정보 화면")
    }
    
    init() {
        print("SearchDetailInfoView")
    }
}

#Preview {
    SearchDetailView(data: Person(name: "테스트", age: 99))
}
