
//
//  TagBadge.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// A small pill / tag badge used as a section category label.
/// e.g. "Love language", "About you", "Relationship"
struct TagBadge: View {

    let title: String
    var foreground: Color = Color(hex: "#5ECFB1")   // mint-teal (matches wireframe)
    var borderColor: Color = Color(hex: "#5ECFB1").opacity(0.5)
    var background: Color = Color(hex: "#5ECFB1").opacity(0.1)

    var body: some View {
        Text(title)
            .font(.system(size: 13, weight: .medium))
            .foregroundStyle(foreground)
            .padding(.horizontal, AppSpacing.sm)
            .padding(.vertical, AppSpacing.xxs + 2)
            .background(
                Capsule()
                    .fill(background)
                    .overlay(
                        Capsule()
                            .stroke(borderColor, lineWidth: 1)
                    )
            )
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppColors.backgroundPrimary.ignoresSafeArea()
        VStack(spacing: AppSpacing.md) {
            TagBadge(title: "Love language")
            TagBadge(title: "About you")
        }
    }
}
