//
//  ExampleBackgroundProcessApp.swift
//  ExampleBackgroundProcess
//
//  Created by Hikaru Sato on 2025/07/27.
//

import SwiftUI
import BackgroundTasks
import FoundationModels


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
//            let startDate = Date.now

            while shouldContinue {
                sleep(1)

                task.progress.completedUnitCount += 1
                task.updateTitle("\(task.progress.completedUnitCount) / \(task.progress.totalUnitCount)", subtitle: "uploading...")
//                let elapsedDate = Date.now.timeIntervalSince(startDate)
//                task.updateTitle(String(format: "%.1f 秒経過", elapsedDate), subtitle: "")
                if task.progress.completedUnitCount == task.progress.totalUnitCount {
                    break
                }
            }

            let completed = task.progress.completedUnitCount >= task.progress.totalUnitCount
            if completed {
                task.updateTitle("Completed", subtitle: "")
            }

            task.setTaskCompleted(success: completed)
        }
    }
}
