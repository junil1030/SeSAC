//
//  AnimationView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/14/25.
//

import SwiftUI

struct AnimationView: View {
    
    @State private var isAnimated = false
    
    var body: some View {
        VStack {
            topTitle()
            cardView()
            Button("AnimationON") {
                withAnimation(.bouncy) {
                    isAnimated = true
                }
            }
            
            Button("AnimationOFF") {
                withAnimation {
                    isAnimated = false
                }
            }
        }
    }
    
    func topTitle() -> some View {
        Text("Hello World")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity,
                   alignment: isAnimated ? .leading : .center)
            .overlay(alignment: .trailing) {
                topOverlayButton()
            }
            .padding()
    }
    
    @ViewBuilder
    func topOverlayButton() -> some View {
        Button {
            withAnimation {
                isAnimated = false
            }
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .padding()
                .background(.black, in: Circle())
        }
        .rotationEffect(.degrees(isAnimated ? 225 : 45))
        .opacity(isAnimated ? 1 : 0)
    }
    
    func cardView() -> some View {
        ScrollView {
            ForEach(0..<5) { item in
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 150)
            }
        }
    }
}

#Preview {
    AnimationView()
}
