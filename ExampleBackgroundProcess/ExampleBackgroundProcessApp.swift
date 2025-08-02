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
            using: nil
        ) { task in
            let task = task as! BGContinuedProcessingTask

            var shouldContinue = true
            task.expirationHandler = {
                shouldContinue = false
            }

            task.progress.totalUnitCount = 100
            task.progress.completedUnitCount = 0

            while shouldContinue {
                // Do some work
                task.progress.completedUnitCount += 1
                if task.progress.completedUnitCount == task.progress.totalUnitCount {
                    break
                }
            }

            task.setTaskCompleted(success: true)
        }
    }
}
