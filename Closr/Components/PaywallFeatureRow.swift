
//
//  PaywallFeatureRow.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// A single feature row for the paywall screen.
/// Displays a mint-teal bullet icon and feature text.
struct PaywallFeatureRow: View {

    let text: String

    var body: some View {
        HStack(alignment: .center, spacing: AppSpacing.sm) {
            // Custom bullet icon (mint-teal circle with inner dot)
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 18, height: 18)
                Circle()
                    .fill(Color(hex: "#5ECFB1"))
                    .frame(width: 8, height: 8)
                Circle()
                    .stroke(Color(hex: "#5ECFB1"), lineWidth: 2.5)
                    .frame(width: 18, height: 18)
            }

            Text(text)
                .font(AppFonts.bodyRegular(size: 15))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)

            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppColors.backgroundPrimary.ignoresSafeArea()
        PaywallFeatureRow(text: "daily AI questions personalized to you")
            .padding()
    }
}
