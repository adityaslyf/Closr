
//
//  OnboardingProgressBar.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// A segmented progress bar for multi-step onboarding flows.
///
/// Usage:
/// ```swift
/// OnboardingProgressBar(totalSteps: 3, currentStep: 2)
/// ```
struct OnboardingProgressBar: View {

    // MARK: - Properties
    let totalSteps: Int
    let currentStep: Int          // 1-indexed

    private let segmentHeight: CGFloat = 3
    private let segmentSpacing: CGFloat = 5
    private let activeColor   = AppColors.brand
    private let inactiveColor = Color.white.opacity(0.2)

    // MARK: - Body
    var body: some View {
        HStack(spacing: segmentSpacing) {
            ForEach(1...totalSteps, id: \.self) { step in
                RoundedRectangle(cornerRadius: segmentHeight / 2)
                    .fill(step <= currentStep ? activeColor : inactiveColor)
                    .frame(height: segmentHeight)
                    .animation(.easeInOut(duration: 0.35), value: currentStep)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: AppSpacing.lg) {
        OnboardingProgressBar(totalSteps: 3, currentStep: 1)
        OnboardingProgressBar(totalSteps: 3, currentStep: 2)
        OnboardingProgressBar(totalSteps: 3, currentStep: 3)
    }
    .padding(AppSpacing.lg)
    .background(AppColors.backgroundPrimary)
}
