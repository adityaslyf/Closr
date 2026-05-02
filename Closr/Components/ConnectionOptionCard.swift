
//
//  ConnectionOptionCard.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// A tappable card representing a single connection option.
/// Renders an icon, title, subtitle, and animated selection state.
struct ConnectionOptionCard: View {

    // MARK: - Properties
    let icon: String          // SF Symbol name
    let title: String
    let subtitle: String
    let isSelected: Bool
    let action: () -> Void

    // MARK: - Body
    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.md) {

                // ── Icon bubble ───────────────────────────────────────────
                ZStack {
                    Circle()
                        .fill(isSelected
                              ? AppColors.brand.opacity(0.18)
                              : AppColors.border)
                        .frame(width: 52, height: 52)

                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(isSelected
                                         ? AppColors.brand
                                         : AppColors.textSecondary)
                }
                .animation(.easeInOut(duration: 0.2), value: isSelected)

                // ── Text ──────────────────────────────────────────────────
                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(AppFonts.bodySemibold(size: 16))
                        .foregroundStyle(AppColors.textPrimary)

                    Text(subtitle)
                        .font(AppFonts.bodyRegular(size: 13))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineSpacing(2)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()

                // ── Selection indicator ───────────────────────────────────
                ZStack {
                    Circle()
                        .stroke(isSelected
                                ? AppColors.brand
                                : Color.white.opacity(0.18),
                                lineWidth: 1.5)
                        .frame(width: 22, height: 22)

                    if isSelected {
                        Circle()
                            .fill(AppColors.brand)
                            .frame(width: 12, height: 12)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .animation(.spring(response: 0.3, dampingFraction: 0.65), value: isSelected)
            }
            .padding(AppSpacing.md)
            .background(
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .fill(AppColors.backgroundCard)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppRadius.md)
                            .stroke(
                                isSelected
                                    ? AppColors.brand.opacity(0.45)
                                    : Color.white.opacity(0.07),
                                lineWidth: 1
                            )
                    )
            )
        }
        .pressAnimation()
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: AppSpacing.md) {
        ConnectionOptionCard(
            icon: "key.fill",
            title: "Enter a code",
            subtitle: "I have a code my partner shared with me",
            isSelected: true,
            action: {}
        )
        ConnectionOptionCard(
            icon: "square.and.arrow.up",
            title: "Share my code",
            subtitle: "Generate a code and send it to my partner",
            isSelected: false,
            action: {}
        )
    }
    .padding(AppSpacing.lg)
    .background(AppColors.backgroundPrimary)
}
