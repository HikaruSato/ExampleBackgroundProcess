//
//  ContentView.swift
//  ExampleBackgroundProcess
//
//  Created by Hikaru Sato on 2025/07/27.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = ContentViewModel()

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("Start Background Task") {
                viewModel.onStartBackgroundTaskTap()
            }
            Button("Start FoundationModels Session") {
                Task {
                    await viewModel.onStartFoundationModelsSessionTap()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
