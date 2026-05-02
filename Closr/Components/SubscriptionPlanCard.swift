
//
//  SubscriptionPlanCard.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Selectable subscription plan card (Monthly vs Annual).
/// Highlights in mint-teal when selected and optionally displays a badge.
struct SubscriptionPlanCard: View {

    let title: String
    let price: String
    let subtitle: String
    let badgeText: String?
    let isSelected: Bool
    let action: () -> Void

    private let teal = Color(hex: "#5ECFB1")

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .top) {
                // Main Card
                VStack(spacing: 4) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(isSelected ? teal : AppColors.textSecondary)
                        .padding(.top, badgeText != nil ? 18 : 0)

                    Text(price)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(isSelected ? AppColors.textPrimary : .white)

                    Text(subtitle)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(isSelected ? teal : AppColors.textSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: AppRadius.md)
                        .fill(isSelected ? teal.opacity(0.12) : AppColors.backgroundCard)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.md)
                        .stroke(
                            isSelected ? teal : AppColors.buttonBackground,
                            lineWidth: isSelected ? 2 : 1
                        )
                )

                // Optional top badge
                if let badgeText = badgeText {
                    Text(badgeText)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            Capsule().fill(teal)
                        )
                        .offset(y: -12) // Half outside the card
                }
            }
            .frame(height: 110)
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
            SubscriptionPlanCard(
                title: "monthly",
                price: "$6.99",
                subtitle: "per month",
                badgeText: nil,
                isSelected: false,
                action: {}
            )

            SubscriptionPlanCard(
                title: "annual",
                price: "$49.99",
                subtitle: "$4.17/mo",
                badgeText: "save 40%",
                isSelected: true,
                action: {}
            )
        }
        .padding(AppSpacing.lg)
    }
}
