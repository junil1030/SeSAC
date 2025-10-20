//
//  YellowBackGroundCornerView.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/20/25.
//

import SwiftUI

// 이런식으로 커스텀 모디파이어를 설정해주는 것은 어쨌든 체이닝이 반복되기 때문에 성능상의 이점은 없음.
// 그러나 휴먼에러와 유지보수의 편함이라는 장점을 가져갈 수 있음
private struct YellowBackGroundCornerView: ViewModifier {
    
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(.green)
            .font(.title)
            .bold()
            .padding()
            .background(.yellow)
            .cornerRadius(cornerRadius)
    }
}

// WWDC에서는 이렇게 extension으로 확장해서 .modifier(~)처럼 불편하게 하지말고
// .asYellowBackGroundCornerView() 이렇게 써라는 거임
// 그리고 이렇게 하면 장점은? YellowBackGroundCornerView를 private하게 바꿀 수 있다.. 그러면 성능상의 이점은 생김 컴파일 최적화가 되니까
extension View {
    
    func asYellowBackGroundCornerView(_ cornerRadius: CGFloat = 10) -> some View {
        modifier(YellowBackGroundCornerView(cornerRadius: cornerRadius))
    }
}
