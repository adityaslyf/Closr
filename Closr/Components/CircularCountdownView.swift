
//
//  CircularCountdownView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// A circular progress indicator used to display hours left.
/// Base circle is a muted mint-teal; progress is solid mint-teal.
struct CircularCountdownView: View {

    let hoursLeft: Int
    let progress: Double // 0.0 to 1.0

    private let teal = Color(hex: "#5ECFB1")

    var body: some View {
        ZStack {
            // Base track
            Circle()
                .stroke(teal.opacity(0.15), lineWidth: 10)

            // Progress track
            Circle()
                .trim(from: 0, to: progress)
                .stroke(teal, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 1.5), value: progress)

            // Value text
            Text("\(hoursLeft)")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(teal)
        }
        .frame(width: 100, height: 100)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppColors.backgroundPrimary.ignoresSafeArea()
        CircularCountdownView(hoursLeft: 12, progress: 0.3)
    }
}
