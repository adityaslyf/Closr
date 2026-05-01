
//
//  FirstQuestionViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

/// Drives the FirstQuestionView (final step in the flow).
@Observable
final class FirstQuestionViewModel {

    // MARK: - State
    var contentVisible: Bool = false
    var progress: Double = 0.0
    var isLoading: Bool = false

    // MARK: - Actions
    func continueFlow(completion: @escaping () -> Void) {
        isLoading = true
        // Simulate a small delay before entering the main app
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.isLoading = false
            completion()
        }
    }

    // MARK: - Lifecycle
    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }

        // Animate the countdown progress ring shortly after entering
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            // E.g. 12 hours out of 24 => 0.5 progress
            self.progress = 0.5
        }
    }
}
