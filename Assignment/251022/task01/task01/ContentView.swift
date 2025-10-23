//
//  ContentView.swift
//  task01
//
//  Created by 서준일 on 10/22/25.
//

import SwiftUI

struct ContentView: View {
    @State var genre: String = ""
    
    var body: some View {
        VStack {
            Text(genre)
                .font(.largeTitle)
            
            HStack {
                NationButton(title: "대한민국", selectedGenre: $genre)
                NationButton(title: "미국", selectedGenre: $genre)
                NationButton(title: "일본", selectedGenre: $genre)
                NationButton(title: "영국", selectedGenre: $genre)
                NationButton(title: "호주", selectedGenre: $genre)
            }
        }
        .padding()
    }
}

struct NationButton: View {
    let title: String
    @Binding var selectedGenre: String
    
    var body: some View {
        Button {
            selectedGenre = title
        } label: {
            Text(title)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }

    }
}

#Preview {
    ContentView()
}
