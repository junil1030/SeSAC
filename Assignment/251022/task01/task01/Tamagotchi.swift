//
//  Tamagotchi.swift
//  task01
//
//  Created by 서준일 on 10/22/25.
//

import SwiftUI

struct Tamagotchi: View {
    @State var totalRiceValue: Int = 0
    @State var inputRiceText: String = ""
    
    @State var totalWaterValue: Int = 0
    @State var inputWaterText: String = ""
    
    var body: some View {
        VStack {
            Text("밥 총합: \(totalRiceValue)")
            HStack {
                Spacer()
                FeedField(text: $inputRiceText)
                FeedButton(image: Image(systemName: "leaf"), title: "밥 주기", inputText: $inputRiceText, value: $totalRiceValue)
                Spacer()
            }
            
            Text("물 총합: \(totalWaterValue)")
            HStack {
                Spacer()
                FeedField(text: $inputWaterText)
                FeedButton(image: Image(systemName: "drop"), title: "물 주기", inputText: $inputWaterText, value: $totalWaterValue)
                Spacer()
            }
        }
    }
}


struct FeedButton: View {
    let image: Image
    let title: String
    
    @Binding var inputText: String
    @Binding var value: Int
    
    var body: some View {
        Button {
            if let number = Int(inputText) {
                value += number
            }
        } label: {
            HStack {
                image
                Text(title)
            }
        }

    }
}

struct FeedField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("얼마나 줄까요?", text: $text)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
    }
}

#Preview {
    Tamagotchi()
}
