
//
//  OnboardingNavBar.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Reusable top navigation bar for onboarding steps.
/// Contains a back chevron button on the leading side and a segmented
/// progress bar centred in the remaining space.
struct OnboardingNavBar: View {

    // MARK: - Properties
    let totalSteps: Int
    let currentStep: Int
    let onBack: () -> Void

    // MARK: - Body
    var body: some View {
        HStack(spacing: AppSpacing.md) {

            // ── Back button ──────────────────────────────────────────────
            Button(action: onBack) {
                ZStack {
                    Circle()
                        .fill(AppColors.buttonBackground)
                        .frame(width: 40, height: 40)

                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)
                }
            }
            .pressAnimation()

            // ── Progress bar ─────────────────────────────────────────────
            OnboardingProgressBar(totalSteps: totalSteps, currentStep: currentStep)

            // ── Invisible spacer to balance the back button width ────────
            Spacer()
                .frame(width: 40)
        }
    }
}

// MARK: - Preview
#Preview {
    VStack {
        OnboardingNavBar(totalSteps: 3, currentStep: 2) {}
            .padding(.horizontal, AppSpacing.lg)
        Spacer()
    }
    .background(AppColors.backgroundPrimary)
}
