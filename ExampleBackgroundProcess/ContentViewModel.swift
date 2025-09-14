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
    @Generable
    struct ContentTaggingResult {
        @Guide(
            description: "Most important actions in the input text.",
            .maximumCount(2)
        )
        let actions: [String]


        @Guide(
            description: "Most important emotions in the input text.",
            .maximumCount(3)
        )
        let emotions: [String]


        @Guide(
            description: "Most important objects in the input text.",
            .maximumCount(5)
        )
        let objects: [String]


        @Guide(
            description: "Most important topics in the input text.",
            .maximumCount(2)
        )
        let topics: [String]
    }

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
        let model = SystemLanguageModel(useCase: .contentTagging)

        let session = LanguageModelSession(model: model, instructions: """
            トピックのコンテキストで最も重要な 2 つのタグを指定します。
            """
        )

        let prompt = "今日は友達とビーチで素敵なピクニックを楽しみました。"

        do {
            let response = try await session.respond(to: prompt, generating: ContentTaggingResult.self)
            print("生成された内容: \(response)")
        } catch {
            print("生成エラー: \(error)")
        }
    }
}
