//
//  SearchView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/27/25.
//

import SwiftUI

struct Person: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let age: Int
}

struct SearchView: View {
    
    @State private var searchText = ""
    @State private var isPresentedTamagotchi = false
    @State private var isPresentedBasicView = false
    
    let list = [
        Person(name: "A", age: 3), Person(name: "B", age: 28),
        Person(name: "C", age: 43), Person(name: "D", age: 59),
        Person(name: "E", age: 12), Person(name: "F", age: 82),
        Person(name: "G", age: 6), Person(name: "H", age: 15),
        Person(name: "I", age: 52), Person(name: "J", age: 19),
        Person(name: "K", age: 49), Person(name: "L", age: 27),
        Person(name: "AA", age: 3), Person(name: "BB", age: 28),
        Person(name: "CC", age: 43), Person(name: "DD", age: 59),
        Person(name: "EE", age: 12), Person(name: "FF", age: 82),
        Person(name: "GG", age: 6), Person(name: "HH", age: 15),
        Person(name: "II", age: 52), Person(name: "JJ", age: 19),
        Person(name: "KK", age: 49), Person(name: "LL", age: 27),
    ]
    
    var filterList: [Person] {
        return searchText.isEmpty ? list : list.filter { $0.name.contains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filterList, id: \.id) { item in
                    NavigationLink {
                        LazyView(content: SearchDetailView(data: item))
                    } label: {
                        setupRows(item)
                    }
                }
            }
            .sheet(isPresented: $isPresentedTamagotchi, content: {
                TamagotchiView()
            })
            .fullScreenCover(isPresented: $isPresentedBasicView, content: {
                BasicView()
            })
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "유저를 검색해보세요")
            .navigationTitle("검색")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "star")
                        .buttonWrapper {
                            isPresentedTamagotchi = true
                        }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Text("AA")
                        .buttonWrapper {
                            isPresentedBasicView = true
                        }
                }
            }
        }
    }
    
    func setupRows(_ item: Person) -> some View {
        HStack {
            Image(systemName: "person.fill")
            Text(item.name)
                .bold()
            Text("\(item.age)")
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    SearchView()
}
