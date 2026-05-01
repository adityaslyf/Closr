
//
//  ClosrLogoMark.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// The animated Venn-diagram logo mark — two overlapping circles
/// forming the "Closr" brand symbol with a glowing lens intersection.
struct ClosrLogoMark: View {

    // MARK: - Animation State
    @State private var isAnimating = false
    @State private var pulseScale: CGFloat = 1.0
    @State private var starOpacity1: Double = 0.3
    @State private var starOpacity2: Double = 0.6

    // MARK: - Layout
    private let outerRingSize: CGFloat  = 260
    private let circleSize: CGFloat     = 130
    private let circleOffset: CGFloat   = 34

    // MARK: - Body
    var body: some View {
        ZStack {
            // ── Outer atmospheric ring ──────────────────────────────────
            Circle()
                .stroke(AppColors.brand.opacity(0.15), lineWidth: 1)
                .frame(width: outerRingSize, height: outerRingSize)

            // ── Soft radial glow background ─────────────────────────────
            Circle()
                .fill(AppColors.radialGlow)
                .frame(width: outerRingSize * 0.88, height: outerRingSize * 0.88)
                .scaleEffect(pulseScale)
                .animation(
                    .easeInOut(duration: 3.5).repeatForever(autoreverses: true),
                    value: pulseScale
                )

            // ── Left circle ─────────────────────────────────────────────
            Circle()
                .stroke(AppColors.brand.opacity(0.55), lineWidth: 1.2)
                .frame(width: circleSize, height: circleSize)
                .offset(x: -circleOffset)

            // ── Right circle ────────────────────────────────────────────
            Circle()
                .stroke(AppColors.brand.opacity(0.55), lineWidth: 1.2)
                .frame(width: circleSize, height: circleSize)
                .offset(x: circleOffset)

            // ── Lens / vesica intersection fill ─────────────────────────
            LensShape(circleRadius: circleSize / 2, offset: circleOffset)
                .fill(AppColors.brandMuted)

            // ── Lens border ─────────────────────────────────────────────
            LensShape(circleRadius: circleSize / 2, offset: circleOffset)
                .stroke(AppColors.brand.opacity(0.3), lineWidth: 0.8)

            // ── Decorative star sparks ──────────────────────────────────
            StarSparkle()
                .frame(width: 6, height: 6)
                .foregroundStyle(AppColors.brand.opacity(starOpacity1))
                .offset(x: -outerRingSize * 0.38, y: -outerRingSize * 0.08)
                .animation(
                    .easeInOut(duration: 2.1).repeatForever(autoreverses: true),
                    value: starOpacity1
                )

            StarSparkle()
                .frame(width: 5, height: 5)
                .foregroundStyle(AppColors.brand.opacity(starOpacity2))
                .offset(x: outerRingSize * 0.38, y: -outerRingSize * 0.12)
                .animation(
                    .easeInOut(duration: 1.7).repeatForever(autoreverses: true),
                    value: starOpacity2
                )
        }
        .frame(width: outerRingSize, height: outerRingSize)
        .onAppear {
            pulseScale  = 1.06
            starOpacity1 = 0.9
            starOpacity2 = 0.2
        }
    }
}

// MARK: - Lens / Vesica Piscis Shape

/// Draws the overlapping almond (vesica piscis) intersection of two circles.
private struct LensShape: Shape {
    let circleRadius: CGFloat
    let offset: CGFloat       // how far each circle centre is from origin

    func path(in rect: CGRect) -> Path {
        let centre = CGPoint(x: rect.midX, y: rect.midY)

        // Intersection points of two circles of equal radius
        let d = offset * 2          // distance between centres
        let h = sqrt(circleRadius * circleRadius - (d / 2) * (d / 2))

        let topPoint    = CGPoint(x: centre.x, y: centre.y - h)
        let bottomPoint = CGPoint(x: centre.x, y: centre.y + h)
        let leftCentre  = CGPoint(x: centre.x - offset, y: centre.y)
        let rightCentre = CGPoint(x: centre.x + offset, y: centre.y)

        var path = Path()

        // Arc from the RIGHT circle (centre = rightCentre) sweeping left side
        let startAngle1 = Angle(radians: atan2(topPoint.y    - rightCentre.y,
                                               topPoint.x    - rightCentre.x))
        let endAngle1   = Angle(radians: atan2(bottomPoint.y - rightCentre.y,
                                               bottomPoint.x - rightCentre.x))
        path.addArc(center: rightCentre,
                    radius: circleRadius,
                    startAngle: startAngle1,
                    endAngle: endAngle1,
                    clockwise: false)

        // Arc from the LEFT circle (centre = leftCentre) sweeping right side
        let startAngle2 = Angle(radians: atan2(bottomPoint.y - leftCentre.y,
                                               bottomPoint.x - leftCentre.x))
        let endAngle2   = Angle(radians: atan2(topPoint.y    - leftCentre.y,
                                               topPoint.x    - leftCentre.x))
        path.addArc(center: leftCentre,
                    radius: circleRadius,
                    startAngle: startAngle2,
                    endAngle: endAngle2,
                    clockwise: false)

        path.closeSubpath()
        return path
    }
}

// MARK: - Star Sparkle Shape

/// A 4-point star / sparkle glyph for ambient decoration.
private struct StarSparkle: Shape {
    func path(in rect: CGRect) -> Path {
        let cx = rect.midX
        let cy = rect.midY
        let r  = min(rect.width, rect.height) / 2
        let inner = r * 0.35

        var path = Path()
        for i in 0..<8 {
            let angle  = Double(i) * .pi / 4 - .pi / 2
            let radius = i.isMultiple(of: 2) ? r : inner
            let x = cx + CGFloat(cos(angle)) * radius
            let y = cy + CGFloat(sin(angle)) * radius
            i == 0 ? path.move(to: CGPoint(x: x, y: y))
                   : path.addLine(to: CGPoint(x: x, y: y))
        }
        path.closeSubpath()
        return path
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppColors.backgroundPrimary.ignoresSafeArea()
        ClosrLogoMark()
    }
}
