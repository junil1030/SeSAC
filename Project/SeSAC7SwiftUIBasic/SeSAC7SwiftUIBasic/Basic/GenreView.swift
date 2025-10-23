//
//  GenreView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/22/25.
//

import SwiftUI

// Spacer + Padding
// HStack(iOS13+) vs LazyHStack(iOS14+)
// .onAppear vs .onDisappear
// ForEach \. Swift Keypath

// HStack {
//     Image(systemName: "star")
//     VStack(alignment: .leading) {
//         Text("Hello, World!")
//         Text("1234개")
//     }
//     Spacer()
// }
// .padding()

struct GenreModel: Hashable, Identifiable {
    // Identifiable을 사용하면 id 속성이 무조건 있어야 하기 때문에 채택해주면 누군가 건들일 일이 없음
    // 그니까 협업적인 측면에서 사용해두면 좋다. 왜냐면 id를 뭐 다른 이름으로 바꿔버리면 컴파일 과정에서 걸러주기 때문에
    let id = UUID()
    let image: String
    let title: String
    let count: Int
}

struct GenreView: View {
    
    @State var typeArray = ["영화", "드라마", "뮤지컬", "애니", "전시회"]
    let genreList = [
        GenreModel(image: "star", title: "SF", count: 12345),
        GenreModel(image: "star.fill", title: "로맨스", count: 12345),
        GenreModel(image: "xmark", title: "스릴러", count: 12345),
        GenreModel(image: "globe.asia.australia", title: "범죄", count: 12345),
        GenreModel(image: "pencil", title: "공포", count: 12345),
        GenreModel(image: "pencil", title: "공포", count: 12345),
        GenreModel(image: "pencil", title: "공포", count: 12345),
        GenreModel(image: "pencil", title: "공포", count: 12345),
        GenreModel(image: "pencil", title: "공포", count: 12345),
    ]
    
    var body: some View {
        VStack {
            Button("카테고리 추가") {
                typeArray.insert("Junil", at: 0)
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(typeArray, id: \.self) { item in
                        TypeCell(title: item)
                    }
                    
                    TypeCell(title: "영화")
                    TypeCell(title: "드라마")
                    TypeCell(title: "애니")
                    TypeCell(title: "추리")
                    TypeCell(title: "뮤지컬")
                }
            }
            ScrollView {
                LazyVStack {
                    ForEach(genreList, id: \.self) { item in
                        GenreCell(image: item.image, title: item.title, count: item.count)
                    }
                }
            }
        }
    }
}

private struct TypeCell: View {
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .frame(width: 100, height: 100)
                .background(.yellow)
                .cornerRadius(10)
        }
        .onAppear {
            print("TypeCell", title)
        }
    }
}

private struct GenreCell: View {
    let image: String
    let title: String
    let count: Int
    
    var body: some View {
        HStack {
            Image(systemName: "\(image)")
            VStack(alignment: .leading) {
                Text(title)
                Text("\(count)")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .onAppear {
            print("GenreCell", title)
        }
    }
}

#Preview {
    GenreView()
}

