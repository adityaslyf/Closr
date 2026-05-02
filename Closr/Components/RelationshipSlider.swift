
//
//  RelationshipSlider.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// A custom-styled relationship-length slider.
/// Ranges from 0 ("just started") to 10 ("10+ years").
/// Displays a dynamic label ("1 year", "3 years", "10+ years", etc.)
/// in brand colour next to the section title.
struct RelationshipSlider: View {

    // MARK: - Binding
    @Binding var value: Double   // 0.0 ... 10.0

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {

            // ── Header row ───────────────────────────────────────────────
            HStack {
                Text("relationship length")
                    .font(AppFonts.bodyRegular(size: 14))
                    .foregroundStyle(AppColors.textSecondary)

                Spacer()

                Text(displayLabel)
                    .font(AppFonts.bodySemibold(size: 14))
                    .foregroundStyle(AppColors.brand)
                    .animation(.none, value: value)
            }

            // ── Track + thumb ────────────────────────────────────────────
            GeometryReader { geo in
                let trackW = geo.size.width
                let thumbX = thumbPosition(in: trackW)

                ZStack(alignment: .leading) {
                    // Full track
                    Capsule()
                        .fill(AppColors.borderActive)
                        .frame(height: 3)

                    // Filled portion
                    Capsule()
                        .fill(AppColors.brand.opacity(0.5))
                        .frame(width: max(thumbX, 0), height: 3)

                    // Thumb
                    Circle()
                        .fill(Color.white)
                        .frame(width: 22, height: 22)
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                        .offset(x: thumbX - 11)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { drag in
                                    let newValue = drag.location.x / trackW * 10.0
                                    value = min(max(newValue, 0), 10)
                                }
                        )
                }
                .frame(height: 22)
            }
            .frame(height: 22)

            // ── Min / max labels ─────────────────────────────────────────
            HStack {
                Text("just started")
                    .font(AppFonts.label(size: 12))
                    .foregroundStyle(AppColors.textSecondary)
                Spacer()
                Text("10+ years")
                    .font(AppFonts.label(size: 12))
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
    }

    // MARK: - Helpers

    private func thumbPosition(in width: CGFloat) -> CGFloat {
        width * CGFloat(value / 10.0)
    }

    private var displayLabel: String {
        let v = Int(value.rounded())
        switch v {
        case 0:       return "just started"
        case 1:       return "1 year"
        case 2...9:   return "\(v) years"
        default:      return "10+ years"
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppColors.backgroundPrimary.ignoresSafeArea()
        VStack(spacing: AppSpacing.xl) {
            RelationshipSlider(value: .constant(1.0))
            RelationshipSlider(value: .constant(5.0))
            RelationshipSlider(value: .constant(10.0))
        }
        .padding(AppSpacing.lg)
    }
}
