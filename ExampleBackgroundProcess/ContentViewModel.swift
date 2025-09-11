//
//  ContentViewModel.swift
//  ExampleBackgroundProcess
//
//  Created by Hikaru Sato on 2025/07/27.
//

import SwiftUI
import BackgroundTasks
import FoundationModels

@Observable
class ContentViewModel {
    func onStartBackgroundTaskTap() {
        do {
            let request = BGContinuedProcessingTaskRequest(
                identifier: ContinuousBackgroundConstants.taskIdentifier,
                title: "upload media",
                subtitle: "uploading...",
            )
            // .queue はタスクリクエストはキューに追加され、後で実行されることがある(default)
            // .fail はタスクリクエストをすぐに実行できない場合にエラーになる
            request.strategy = .queue
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Failed to submit request: \(error)")
        }
    }

    func onStartFoundationModelsSessionTap() async {
        // セッションの作成（必要に応じて instructions や options を追加可能）
        let session = LanguageModelSession()

        let prompt = "簡単な朝食レシピを教えて"
        let options = GenerationOptions(temperature: 1.0)

        do {
            let response = try await session.respond(to: prompt, options: options)
            print("生成された内容: \(response)")
        } catch {
            print("生成エラー: \(error)")
        }
    }
}
