
//
//  PrimaryButton.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Full-width primary CTA button used across the onboarding flow.
/// Supports a trailing SF Symbol chevron icon.
struct PrimaryButton: View {

    // MARK: - Properties
    let title: String
    let action: () -> Void
    var showChevron: Bool = true
    var isLoading: Bool   = false

    // MARK: - Body
    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.xs) {
                Spacer()

                if isLoading {
                    ProgressView()
                        .tint(AppColors.buttonPrimaryText)
                } else {
                    Text(title)
                        .font(AppFonts.bodySemibold(size: 17))
                        .foregroundStyle(AppColors.buttonPrimaryText)

                    if showChevron {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(AppColors.buttonPrimaryText)
                    }
                }

                Spacer()
            }
            .frame(height: 56)
            .background(AppColors.buttonPrimary)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.pill))
        }
        .pressAnimation()
        .disabled(isLoading)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppColors.backgroundPrimary.ignoresSafeArea()
        PrimaryButton(title: "Start Journey") {}
            .padding(.horizontal, AppSpacing.lg)
    }
}
