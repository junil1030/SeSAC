//
//  EnvExampleView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/12/25.
//

import SwiftUI

class SettingModel: ObservableObject {
    @Published var isAlarmOn = false
}

struct EnvExampleView: View {
    
    @StateObject private var viewModel = SettingModel()
    
    var body: some View {
        VStack {
            Text(viewModel.isAlarmOn ? "알림 받기": "알림 받지 않기")
            EnvFirstView()
        }
        .environmentObject(viewModel)
    }
}


struct EnvFirstView: View {
    var body: some View {
        Text("EnvFirstView")
        EnvSecondView()
    }
}

struct EnvSecondView: View {
    var body: some View {
        Text("EnvSecondView")
        EnvLastView()
    }
}

struct EnvLastView: View {
    
    @EnvironmentObject var viewModel: SettingModel
    
    var body: some View {
        VStack {
            Text(viewModel.isAlarmOn ? "알림 받기": "알림 받지 않기")
            Toggle("알람 설정", isOn: $viewModel.isAlarmOn)
        }
    }
}

#Preview {
    EnvExampleView()
}
