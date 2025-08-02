//
//  ExampleBackgroundProcessApp.swift
//  ExampleBackgroundProcess
//
//  Created by Hikaru Sato on 2025/07/27.
//

import SwiftUI
import BackgroundTasks

@main
struct ExampleBackgroundProcessApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    init() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: ContinuousBackgroundConstants.taskIdentifier,
            using: dispatch_queue_t.global(qos: .background)
        ) { task in
            guard let task = task as? BGContinuedProcessingTask else { return }

            task.progress.totalUnitCount = 100
            for _ in 0..<100 {
                task.progress.completedUnitCount += 1
            }

            // タスクの正常終了を必ず明示！
            task.setTaskCompleted(success: true)
        }
    }
}
