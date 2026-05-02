
//
//  LoveLanguageCard.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// A single selectable love-language option card.
/// Displays an emoji icon, bold title, and muted subtitle.
/// Animates its border and background tint when selected.
struct LoveLanguageCard: View {

    // MARK: - Properties
    let iconName: String
    let title: String
    let subtitle: String
    let isSelected: Bool
    let action: () -> Void

    // MARK: - Body
    var body: some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xs) {

                // Icon
                Image(systemName: iconName)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(AppColors.brand)
                    .padding(.top, AppSpacing.sm)

                // Title
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(AppColors.textPrimary)

                // Subtitle
                Text(subtitle)
                    .font(AppFonts.bodyRegular(size: 13))
                    .foregroundStyle(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
                    .padding(.horizontal, AppSpacing.xs)
                    .padding(.bottom, AppSpacing.sm)
            }
            .frame(maxWidth: .infinity, minHeight: 118)
            .background(
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .fill(isSelected
                          ? AppColors.brand.opacity(0.1)
                          : AppColors.backgroundCard)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppRadius.md)
                            .stroke(
                                isSelected
                                    ? AppColors.brand.opacity(0.7)
                                    : Color.white.opacity(0.07),
                                lineWidth: isSelected ? 1.5 : 1
                            )
                    )
            )
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .pressAnimation()
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppColors.backgroundPrimary.ignoresSafeArea()
        HStack(spacing: AppSpacing.sm) {
            LoveLanguageCard(iconName: "bubble.left.and.heart.fill", title: "words", subtitle: "affirmation & praise", isSelected: true,  action: {})
            LoveLanguageCard(iconName: "clock.fill", title: "time",  subtitle: "quality time together", isSelected: false, action: {})
        }
        .padding(AppSpacing.lg)
    }
}
