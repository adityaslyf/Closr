
//
//  FlowLayout.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// A custom SwiftUI `Layout` that wraps child views into rows,
/// left-aligned, similar to CSS flexbox `flex-wrap: wrap`.
/// Requires iOS 16+ (uses the `Layout` protocol).
struct FlowLayout: Layout {

    var horizontalSpacing: CGFloat = 8
    var verticalSpacing: CGFloat   = 8

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let result = flow(in: proposal.replacingUnspecifiedDimensions().width,
                          subviews: subviews)
        return result.totalSize
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let result = flow(in: bounds.width, subviews: subviews)
        for (index, frame) in result.frames.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY),
                proposal: ProposedViewSize(frame.size)
            )
        }
    }

    // MARK: - Private

    private struct FlowResult {
        var frames: [CGRect]
        var totalSize: CGSize
    }

    private func flow(in width: CGFloat, subviews: Subviews) -> FlowResult {
        var frames: [CGRect] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var lineHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            // Wrap to next row if needed
            if x + size.width > width, x > 0 {
                x = 0
                y += lineHeight + verticalSpacing
                lineHeight = 0
            }

            frames.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
            lineHeight = max(lineHeight, size.height)
            x += size.width + horizontalSpacing
        }

        let totalHeight = y + lineHeight
        return FlowResult(frames: frames, totalSize: CGSize(width: width, height: totalHeight))
    }
}
