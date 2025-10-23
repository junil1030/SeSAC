//
//  CategoryView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/21/25.
//

import SwiftUI
/*
 - 테이블뷰나 컬렉션뷰처럼
 - 클릭 이벤트의 범위
    - titleKey, action
 */
struct CategoryView: View {
    var body: some View {
        HStack {
            category
                .buttonWrapper {
                    print("첫번째 카테고리입니다.")
                }
            
            AsyncImage(url: URL(string: "https://picsum.photos/100"))
                .buttonWrapper {
                    print("두번째 카테고리입니다.")
                }
            
            category
                .buttonWrapper {
                    print("세번째 카테고리입니다.")
                }
        }
        
        category
        Button("액션") {
            print("액션을 선택했어요.")
        }
        .frame(width: 100, height: 100)
        .background(.yellow)
    }
    
    var category: some View {
        VStack {
            Image(systemName: "star")
            Text("국내 주식")
        }
        .background(.green)
    }
}

#Preview {
    CategoryView()
}
