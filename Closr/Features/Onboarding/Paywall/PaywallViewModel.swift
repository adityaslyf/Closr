
//
//  PaywallViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

/// The available subscription plans.
enum SubscriptionPlan {
    case monthly
    case annual
}

/// Drives the PaywallView.
@Observable
final class PaywallViewModel {

    // MARK: - State
    var selectedPlan: SubscriptionPlan = .annual
    var contentVisible: Bool = false
    var isLoading: Bool = false

    // MARK: - Computed
    var ctaTitle: String {
        "start free trial"
    }

    // MARK: - Actions
    func selectPlan(_ plan: SubscriptionPlan) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedPlan = plan
        }
    }

    func startFreeTrial(completion: @escaping () -> Void) {
        isLoading = true
        // Simulate a network request or IAP transaction
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.isLoading = false
            completion()
        }
    }

    // MARK: - Lifecycle
    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
