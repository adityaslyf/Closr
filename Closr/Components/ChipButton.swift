
//
//  ChipButton.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// A selectable pill/chip button used for multi-select tag pickers.
///
/// Unselected: dark card + subtle outline.
/// Selected:   brand-pink border + blush tint background + white text.
struct ChipButton: View {

    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? AppColors.textPrimary : AppColors.textSecondary)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(isSelected
                              ? AppColors.brand.opacity(0.12)
                              : AppColors.backgroundCard)
                        .overlay(
                            Capsule()
                                .stroke(
                                    isSelected
                                        ? AppColors.brand.opacity(0.75)
                                        : AppColors.borderActive,
                                    lineWidth: 1
                                )
                        )
                )
                .animation(.easeInOut(duration: 0.18), value: isSelected)
        }
        .pressAnimation()
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppColors.backgroundPrimary.ignoresSafeArea()
        HStack(spacing: 8) {
            ChipButton(title: "communication", isSelected: true,  action: {})
            ChipButton(title: "intimacy",      isSelected: false, action: {})
        }
        .padding(AppSpacing.lg)
    }
}
