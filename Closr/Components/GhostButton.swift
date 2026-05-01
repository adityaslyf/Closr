
//
//  GhostButton.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Transparent / ghost secondary CTA button.
/// Used for lower-priority actions like "I have an invite code".
struct GhostButton: View {

    // MARK: - Properties
    let title: String
    let action: () -> Void
    var textColor: Color = AppColors.textSecondary

    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFonts.bodyMedium(size: 16))
                .foregroundStyle(textColor)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .pressAnimation()
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppColors.backgroundPrimary.ignoresSafeArea()
        GhostButton(title: "I have an invite code") {}
    }
}
