//
//  ContentViewModel.swift
//  ExampleBackgroundProcess
//
//  Created by Hikaru Sato on 2025/07/27.
//

import SwiftUI
import BackgroundTasks

@Observable
class ContentViewModel {
    func onStartBackgroundTaskTap() {
        do {
            let request = BGContinuedProcessingTaskRequest(
                identifier: ContinuousBackgroundConstants.taskIdentifier,
                title: "upload media",
                subtitle: "uploading...",
            )
            // An option that fails the submission of a continuous background task if the system can’t run it immediately.
            request.strategy = .fail
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Failed to submit request: \(error)")
        }
    }
}
